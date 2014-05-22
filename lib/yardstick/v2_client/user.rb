require 'yardstick/v2_client/remote_model'
require 'yardstick/cacheable'

module Yardstick
  module V2Client
    class User
      include RemoteModel
      include Cacheable

      cached_accessor :id, :username, :first_name, :last_name, :email, :roles
    end
  end
end
