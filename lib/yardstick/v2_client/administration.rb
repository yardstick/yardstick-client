require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Administration
      include RemoteModel
      attr_accessor :name, :id, :site_id

      resource_uri '/v2/administrations'
    end
  end
end
