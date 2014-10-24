module Yardstick
  module V2Client
    class Incident
      include RemoteModel

      attr_accessor :id, :source_id, :source_type, :created_at, :updated_at, :notes
      attr_accessor :incident_datetime
      attr_accessor :proctor_ids, :proctors, :user_ids, :users
      attr_accessor :reporting_proctor_id, :reporting_proctor
    end
  end
end
