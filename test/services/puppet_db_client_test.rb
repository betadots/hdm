require 'test_helper'

class PuppetDBClientTest < ActiveSupport::TestCase
  def teardown
    Settings.puppet_db.enabled = false
  end

  test "default is disabled" do
    refute Settings.puppet_db.enabled

    assert_equal [], PuppetDBClient.nodes
  end

  test "when enabled get nodes from PuppetDB" do
    Settings.puppet_db.server = "http://localhost:32769"
    Settings.puppet_db.enabled = true
    assert Settings.puppet_db.enabled

    @commander = Minitest::Mock.new
    @commander.expect :request, puppetdb_data, ["nodes", nil, {}]

    PuppetDBClient.stub :client, @commander do
      assert_equal ["puppetdb_host"], PuppetDBClient.nodes
    end

    @commander.verify
  end

  def puppetdb_data
    data = [{
      "deactivated"=>nil,
      "latest_report_hash"=>"9d20e245c912d00fc882164d4daee0e21d5d367e",
      "facts_environment"=>"production",
      "cached_catalog_status"=>"not_used",
      "report_environment"=>"production",
      "latest_report_corrective_change"=>nil,
      "catalog_environment"=>"production",
      "facts_timestamp"=>"2019-11-29T14:47:31.885Z",
      "latest_report_noop"=>false,
      "expired"=>nil,
      "latest_report_noop_pending"=>false,
      "report_timestamp"=>"2019-11-29T14:47:32.535Z",
      "certname"=>"puppetdb_host",
      "catalog_timestamp"=>"2019-11-29T14:47:32.421Z",
      "latest_report_job_id"=>nil,
      "latest_report_status"=>"unchanged"
    }]
    PuppetDB::Response.new(data, data.size)
  end
end
