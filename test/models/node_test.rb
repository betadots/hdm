require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  test "list the nodes" do
    assert_equal ['testhost', 'testhost2', 'testhost3'], Node.all_names.sort
  end

  test "create node object" do
    assert Node.new('testhost')
  end

  test "raise error for non existing nodes" do
    err = assert_raises(Node::NotFound) { Node.new('unknown') }
    assert_match("Node 'unknown' does not exist", err.message)
  end

  test "do not raise error when skipping validation" do
    assert_nothing_raised do
      Node.new("unknown", skip_validation: true)
    end
  end

  test "two nodes are equal when their hostnames are identical" do
    node_one = Node.new("testhost")
    node_two = Node.new("testhost")
    assert_equal node_one, node_two
  end

  test "two nodes are not equal when they have different hostnames" do
    node_one = Node.new("testhost")
    node_two = Node.new("testhost2")
    assert_not_equal node_one, node_two
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

  test "#to_param should return the hostname" do
    node = Node.new("testhost")
    assert_equal "testhost", node.to_param
  end

  test "#to_s should return the hostname" do
    node = Node.new("testhost")
    assert_equal "testhost", node.to_s
  end
end
