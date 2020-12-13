require 'test_helper'

class PuppetNodesControllerTest < ActionDispatch::IntegrationTest
  # setup do
  #   @puppet_node = puppet_nodes(:one)
  # end

  # test "should get index" do
  #   get puppet_nodes_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_puppet_node_url
  #   assert_response :success
  # end

  # test "should create puppet_node" do
  #   assert_difference('PuppetNode.count') do
  #     post puppet_nodes_url, params: { puppet_node: { config_file_name: @puppet_node.config_file_name, fqdn: @puppet_node.fqdn, organization: @puppet_node.organization, os_family: @puppet_node.os_family, os_lsbdistcodename: @puppet_node.os_lsbdistcodename, puppet_environment_id: @puppet_node.puppet_environment_id, role: @puppet_node.role, zone: @puppet_node.zone } }
  #   end

  #   assert_redirected_to puppet_node_url(PuppetNode.last)
  # end

  # test "should show puppet_node" do
  #   get puppet_node_url(@puppet_node)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_puppet_node_url(@puppet_node)
  #   assert_response :success
  # end

  # test "should update puppet_node" do
  #   patch puppet_node_url(@puppet_node), params: { puppet_node: { config_file_name: @puppet_node.config_file_name, fqdn: @puppet_node.fqdn, organization: @puppet_node.organization, os_family: @puppet_node.os_family, os_lsbdistcodename: @puppet_node.os_lsbdistcodename, puppet_environment_id: @puppet_node.puppet_environment_id, role: @puppet_node.role, zone: @puppet_node.zone } }
  #   assert_redirected_to puppet_node_url(@puppet_node)
  # end

  # test "should destroy puppet_node" do
  #   assert_difference('PuppetNode.count', -1) do
  #     delete puppet_node_url(@puppet_node)
  #   end

  #   assert_redirected_to puppet_nodes_url
  # end
end
