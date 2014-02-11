require 'ostruct'
require 'yardstick/v2_client/remote_model'
require 'yardstick/v2_client/rubric_section'

module Yardstick
  module V2Client
    class Question
      include RemoteModel

      resource_uri '/v2/questions'

      attr_accessor :id, :canonical_id, :passage_id, :passage, :item_bank_id, :topic_id, :created_by_id, :locale, :html, :paths, :rubric_sections, :workflow_state

      def self.assets
        OpenStruct.new(get('/v2/questions/assets').parsed_response)
      end

      def self.mathjax_url
        "#{base_uri}/javascripts/vendor/MathJax/MathJax.js?config=yardstick"
      end

      def self.from_api(resp, extras = {})
        return nil if resp.nil?
        resp = resp.parsed_response if resp.respond_to?(:parsed_response)
        attrs = resp.with_indifferent_access
        attrs.merge!(paths: OpenStruct.new(attrs[:paths]))
        attrs.merge!(rubric_sections: RubricSection.from_api(attrs[:rubric_sections]))
        attrs.merge!(passage: Passage.from_api(attrs[:passage])) if attrs[:passage].present?
        attrs.merge!(extras)
        new(attrs)
      end

      def self.find(id, options = {})
        find_by_url("/v2/questions/#{id}", options)
      end

      def self.find_by_url(url, options = {})
        response = get(url, body: options)
        return response if response.code > 399
        from_api(response)
      end
    end
  end
end
