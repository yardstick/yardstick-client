module Yardstick
  module V2Client
    class Grant
      include RemoteModel

      class << self
        def check_status(token, grant_id)
          Status.new(true, 'http://clientsite.yardstickmeasure.com/write/123456')
        end
      end

      Status = Struct.new(:valid, :write_url) do
        alias_method :valid?, :valid
      end
    end
  end
end
