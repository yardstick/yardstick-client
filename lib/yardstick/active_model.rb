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
        if respond_to?("#{attr}=")
          public_send("#{attr}=", value)
        else
          ActiveSupport::Deprecation.warn("Unknown attribute '#{attr}' for '#{self.class.name}'. Your client gem may be out of date compared to the current Yardstick API version.")
        end
      end if params
    end

    def persisted?
      false
    end

    ActiveSupport.on_load(:active_model_serializers) do
      ActiveModel.send(:include, ::ActiveModel::SerializerSupport)
    end

    class Base
      include ActiveModel
    end
  end
end
