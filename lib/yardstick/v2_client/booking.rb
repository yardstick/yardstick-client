require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Booking
      include RemoteModel

      attr_accessor :id,
                    :cancellation_note,
                    :created_at,
                    :updated_at,
                    :deleted_at,
                    :virtual_proctoring_start_at,
                    :virtual_proctoring_end_at,
                    :user,
                    :grant,
                    :sitting
    end
  end
end
