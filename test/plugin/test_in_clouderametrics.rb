require "helper"
require "fluent/plugin/in_clouderametrics.rb"

class ClouderametricsInputTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Input.new(Fluent::Plugin::ClouderametricsInput).configure(conf)
  end
end
