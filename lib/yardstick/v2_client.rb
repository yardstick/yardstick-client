require 'yardstick/active_model'
require 'yardstick/v2_client/collection_proxy'
require 'yardstick/v2_client/party_pooper'
require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    extend HTTParty::ClassMethods
    extend Yardstick::V2Client::PartyPooper::ClassMethods
    extend ActiveSupport::Autoload

    autoload :Account
    autoload :AdminUser
    autoload :Administration
    autoload :Answer
    autoload :Attachment
    autoload :Authentication
    autoload :BookingRequest
    autoload :Exam
    autoload :ExamDeliveryStatusMessage
    autoload :ExamForm
    autoload :ExamQuestion
    autoload :MeasureServiceError
    autoload :NomadUser
    autoload :Passage
    autoload :Question
    autoload :RubricCriteria
    autoload :RubricSection
    autoload :TestCentreTimeWindow
    autoload :Unauthorized
    autoload :User
    autoload :UserExam
    autoload :UserExamQuestion
    autoload :Venue

    mattr_accessor :default_options, :default_cookies

    self.default_options = {}
    self.default_cookies = HTTParty::CookieHash.new

    base_uri ENV.fetch('MEASURE_BASE_URL', 'http://admin.dev')

    def self.whoami(token)
      response = get('/v2/whoami', query: { token: token })
      class_name = response.delete('klass')
      "Yardstick::V2Client::#{class_name}".constantize.from_api(response)
    end
  end
end
