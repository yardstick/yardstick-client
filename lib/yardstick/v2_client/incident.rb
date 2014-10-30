module Yardstick
  module V2Client
    class Incident
      include RemoteModel

      resource_uri '/v2/incidents'

      attr_accessor :id, :source_id, :source_type, :created_at, :updated_at, :incident_type, :notes
      attr_accessor :incident_datetime
      attr_accessor :proctor_ids, :proctors, :user_ids, :users
      attr_accessor :reporting_proctor_id, :reporting_proctor

      def self.types(token)
        response = get(action_uri(:types), query: { token: token })
        response['types']
      end
    end
  end
end
