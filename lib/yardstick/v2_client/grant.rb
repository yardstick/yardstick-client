require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Grant
      include RemoteModel

      class Paths < Yardstick::ActiveModel::Base
        attr_accessor :bookings
      end

      attr_accessor :id, :user_id, :type, :num_uses, :metadata, :parent_grant_id
      attr_accessor :grantable_id, :grantable_type
      attr_accessor :start_at, :expire_at
      attr_accessor :created_at, :updated_at, :deleted_at
      attr_accessor :exam_form_id, :exam_form_group, :allow_sittings_start_at, :allow_sittings_end_at
      attr_accessor :user, :exam, :exam_form, :paths

      def self.process_response(resp, extra = {})
        attrs = super
        attrs.merge!(:paths => Paths.new(attrs[:paths]))
      end
    end
  end
end
