require 'yardstick/v2_client/party_pooper'
require 'yardstick/active_model'
require 'lol_concurrency'
require 'remote_associations'

module Yardstick
  module V2Client
    module RemoteModel
      extend ActiveSupport::Concern

      included do
        include HTTParty
        include PartyPooper
        include Yardstick::ActiveModel
        include LolConcurrency::Future
        extend LolConcurrency::Future
        include RemoteAssociations

        base_uri ENV.fetch('MEASURE_BASE_URL', 'http://admin.dev')
      end

      def put(*args)
        self.class.put(*args)
      end

      module ClassMethods
        def find(token, id)
          from_api(get("#{resource_uri}/#{id}", query: { token: token }))
        end

        def find_by(token, options = {})
          response = get_all(token, options)
          from_api(response.first)
        end

        def from_api(resp, extras = {})
          return nil if resp.nil?
          new(process_response(resp, extras))
        end

        def process_response(resp, extras = {})
          resp = resp.parsed_response if resp.respond_to?(:parsed_response)
          attrs = resp.with_indifferent_access
          attrs.merge!(extras)
        end

        def resource_uri(uri = :getter)
          return @resource_uri if uri == :getter
          @resource_uri = uri
        end

        def get_all(*args)
          options = args.extract_options!
          token = args.shift
          uri = args.shift || resource_uri
          get(uri, query: options.merge(token: token))
        end

        def query_all(*args)
          CollectionProxy.new(self) do
            get_all(*args)
          end
        end

        def all(token, options = {})
          query_all(token, options)
        end

        def from_array(response)
          response.map { |r| from_api(r) }
        end

        def method_missing(method, *args, &block)
          if method.to_s =~ /^all_indexed_on_(.+)$/
            response = get_all(*args)
            return response.reduce({}) do |result, attrs|
              instance = from_api(attrs)
              result[instance.send($1)] = instance
              result
            end
          end
          super
        end

        def respond_to_missing?(method, include_priv = false)
          if method.to_s =~ /^all_indexed_on_(.+)$/
            return attribute_method?($1)
          end
          super
        end
      end
    end
  end
end
