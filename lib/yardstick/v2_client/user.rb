require 'yardstick/v2_client/remote_model'
require 'yardstick/cacheable'

module Yardstick
  module V2Client
    class User
      include RemoteModel
      include Cacheable

      cached_accessor :id, :username, :first_name, :last_name, :email, :roles

      attr_accessor :metadata,
                    :active,
                    :site_id,
                    :created_at,
                    :alternate_email_verified,
                    :alternate_email,
                    :email_verified,
                    :deleted_at,
                    :updated_at,
                    :address
    end
  end
end
