require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  test "list the nodes" do
    assert_equal ['testhost', 'testhost2', 'testhost3'], Node.all_names.sort
  end

  test "access node object" do
    assert Node.new('testhost')
  end

  test "raise error for non existing nodes" do
    err = assert_raises(Node::NotFound) { Node.new('unknown') }
    assert_match("Node 'unknown' does not exist", err.message)
  end

  test "check facts" do
    node = Node.new('testhost')
    expected_facts = {
      "fqdn"=>"testhost",
      "role"=>"hdm_test",
      "env"=>"development",
      "zone"=>"internal",
      "os"=>{"family"=>"RedHat"},
      "organization"=>"internal"
    }
    assert_equal expected_facts, node.facts(environment: "development")
  end
end
