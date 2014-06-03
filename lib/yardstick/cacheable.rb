require 'active_support'
require 'set'

module Yardstick
  module Cacheable
    extend ActiveSupport::Concern

    def marshal_dump
      self.class.cached_attributes.map { |attribute| send(attribute) }
    end

    def marshal_load(values)
      self.class.cached_attributes.each_with_index do |attribute, i|
        send("#{attribute}=", values[i])
      end
    end

    module ClassMethods
      def cached_accessor(*args)
        attr_accessor *args
        cache(*args)
      end

      def cache(*args)
        cached_attributes.merge(args)
      end

      def cached_attributes
        @cached_attributes ||= Set.new
      end
    end
  end
end
