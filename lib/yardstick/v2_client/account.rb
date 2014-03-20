require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Account
      include RemoteModel

      attr_accessor :id, :name, :short_name
    end
  end
end
