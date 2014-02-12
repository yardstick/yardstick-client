module Yardstick
  module V2Client
    class User
      include RemoteModel

      attr_accessor :id, :username, :first_name, :last_name, :email, :roles
    end
  end
end
