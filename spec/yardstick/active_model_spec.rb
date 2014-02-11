require 'spec_helper'
require 'active_support/testing/deprecation'
require 'ruby-debug'

describe Yardstick::ActiveModel do
  include ActiveSupport::Testing::Deprecation

  def assert(condition, message)
    expect(condition).to be_true, message
  end

  let(:test_class) do
    class TestClass
      include Yardstick::ActiveModel

      attr_accessor :lollipops
    end
    TestClass
  end

  describe '#initialize' do
    it 'should report a deprecation warning when you send an attribute it does not know about' do
      assert_deprecated(/Unknown attribute 'some_other_attributes'/) do
        test_class.new(lollipops: 'are sweet', some_other_attributes: 'are not')
      end
    end
  end
end
