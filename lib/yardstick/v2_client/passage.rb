require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Passage
      include RemoteModel

      attr_accessor :id, :created_by_id, :name, :item_bank_id, :created_at, :updated_at, :truncate

      resource_uri '/v2/passages'
    end
  end
end
