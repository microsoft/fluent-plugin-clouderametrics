require "helper"
require "fluent/plugin/in_clouderametrics.rb"
require 'net/http'
require "uri"

class ClouderametricsInputTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  CONFIG_CLOUDERA_METRICS = %[
    tag clouderametrics
    timespan 2
    user username
    pass password
    host http://localhost
    port 7180
    api_endpoint sampleendpoint
    api_version v1
    query select+cpu_user_rate+where+roletype=datanode
  ]

  def create_driver(conf = CONFIG_CLOUDERA_METRICS)
    Fluent::Test::Driver::Input.new(Fluent::Plugin::ClouderametricsInput).configure(conf)
  end

  def test_get_cloudera_metrics
    d = create_driver
    driverInstance = d.instance

    mockUrl = URI("#{driverInstance.host}:#{driverInstance.port}/api/#{driverInstance.api_version}/#{driverInstance.api_endpoint}")
    stub_request(:get, mockUrl).to_return(body: "123", status: 200)
    payload = Net::HTTP.get(mockUrl)
    assert_equal payload, "123"
  end
end
