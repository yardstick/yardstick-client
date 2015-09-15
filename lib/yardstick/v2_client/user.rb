require 'yardstick/v2_client/remote_model'
require 'yardstick/cacheable'

module Yardstick
  module V2Client
    class User
      include RemoteModel
      include Cacheable

      class Paths < Yardstick::ActiveModel::Base
        attr_accessor :grants
      end

      resource_uri '/v2/users'

      cached_accessor :id, :username, :first_name, :last_name, :email, :roles

      attr_accessor :metadata,
                    :active,
                    :site_id,
                    :created_at,
                    :alternate_email_verified,
                    :alternate_email,
                    :email_verified,
                    :deleted_at,
                    :updated_at,
                    :address,
                    :time_zone

      attr_accessor :paths

      def self.process_response(resp, extra = {})
        attrs = super
        attrs.merge!(:paths => Paths.new(attrs[:paths]))
      end

      def create_booking(grant_id, params = {})
        grant = find_grant(grant_id)
        params.merge!(token: token)

        response = Grant.post(grant.paths.bookings, body: params)
        Booking.from_api(response)
      end

      def find_grant(grant_id)
        response = Grant.get("#{paths.grants}/#{grant_id}", body: {
          token: token,
          user_id: id,
          id: grant_id
        })
        Grant.from_api(response)
      end
    end
  end
end
