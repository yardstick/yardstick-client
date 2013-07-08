module Yardstick
  # Pulled from Rails 4... just because it looks so handy..
  module ActiveModel
    extend ActiveSupport::Concern

    included do
      extend ::ActiveModel::Naming
      extend ::ActiveModel::Translation
      include ::ActiveModel::Validations
      include ::ActiveModel::Conversion
    end

    def initialize(params = {})
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params
    end

    def persisted?
      false
    end

    # Fake out so we can use serializers
    def read_attribute_for_serialization(attribute)
      send(attribute)
    end

    class Base
      include ActiveModel
    end
  end
end