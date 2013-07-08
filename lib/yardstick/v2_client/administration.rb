require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Administration
      include RemoteModel

      attr_accessor :name, :id, :site_id

      def self.all(token)
        response = get('/v2/administrations', body: { token: token })
        response.map do |r|
          Administration.new(r)
        end
      end
    end
  end
end
