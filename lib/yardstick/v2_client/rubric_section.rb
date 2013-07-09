require 'yardstick/v2_client/rubric_criteria'

module Yardstick
  module V2Client
    class RubricSection
      include RemoteModel

      attr_accessor :id, :description, :question_id, :keys, :rubric_criterion

      def self.from_api(resp, extras = {})
        resp = resp.parsed_response if resp.respond_to?(:parsed_response)
        if resp.respond_to?(:with_indifferent_access)
          attrs = resp.with_indifferent_access
          attrs.merge!(rubric_criterion: RubricCriteria.from_api(Array(attrs[:rubric_criterion])))
          attrs.merge!(extras)
          new(attrs)
        else
          Array(resp).map { |r| from_api(r, extras) }
        end
      end
    end
  end
end
