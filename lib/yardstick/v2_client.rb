require 'yardstick/active_model'
require 'yardstick/v2_client/admin_user'
require 'yardstick/v2_client/administration'
require 'yardstick/v2_client/answer'
require 'yardstick/v2_client/authentication'
require 'yardstick/v2_client/party_pooper'
require 'yardstick/v2_client/passage'
require 'yardstick/v2_client/question'
require 'yardstick/v2_client/remote_model'
require 'yardstick/v2_client/rubric_criteria'
require 'yardstick/v2_client/rubric_section'
require 'yardstick/v2_client/unauthorized'
require 'yardstick/v2_client/user_exam'
require 'yardstick/v2_client/user_exam_question'

module Yardstick
  module V2Client
    extend HTTParty::ClassMethods
    extend Yardstick::V2Client::PartyPooper::ClassMethods

    mattr_accessor :default_options, :default_cookies

    self.default_options = {}
    self.default_cookies = HTTParty::CookieHash.new

    base_uri ENV.fetch('MEASURE_BASE_URL', 'http://admin.dev')

    def self.whoami(token)
      response = get('/v2/whoami', body: { token: token })
      class_name = response.delete('klass')
      "Yardstick::V2Client::#{class_name}".constantize.from_api(response)
    end
  end
end
