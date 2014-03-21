require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Attachment
      include RemoteModel

      attr_accessor :id, :file_name, :file_url
    end
  end
end
