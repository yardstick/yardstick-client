require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class RubricCriteria
      include RemoteModel

      attr_accessor :id, :description, :point_value, :rubric_section_id

      def self.from_api(resp, extras = {})
        resp = resp.parsed_response if resp.respond_to?(:parsed_response)
        if resp.respond_to?(:with_indifferent_access)
          attrs = resp.with_indifferent_access
          attrs.merge!(extras)
          new(attrs)
        else
          Array(resp).map { |r| from_api(r, extras) }
        end
      end
    end
  end
end
