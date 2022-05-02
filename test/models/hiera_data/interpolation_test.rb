require 'test_helper'

class HieraData::InterpolationTest < ActiveSupport::TestCase
  test "::interpolate_globs handles globs" do
    datadir = Rails.root.join("test/fixtures/files/puppet/environments/globs/data")
    path = "common/*.yaml"
    expected_result = [
      "common/foobar.yaml",
      "common/hdm.yaml"
    ]

    assert_equal expected_result, HieraData::Interpolation.interpolate_globs(path: path, datadir: datadir)
  end

  test "::interpolate_facts replaces facts with leading colons" do
    path = "/test/%{::test_fact}/file"
    facts = {"test_fact" => "replaced"}
    expected_result = "/test/replaced/file"

    assert_equal expected_result, HieraData::Interpolation.interpolate_facts(path: path, facts: facts)
  end

  test "::interpolate_facts replaces facts without leading colons" do
    path = "/test/%{test_fact}/file"
    facts = {"test_fact" => "replaced"}
    expected_result = "/test/replaced/file"

    assert_equal expected_result, HieraData::Interpolation.interpolate_facts(path: path, facts: facts)
  end

  test "::interpolate_facts replaces facts with `facts.` scope" do
    path = "/test/%{facts.test_fact}/file"
    facts = {"test_fact" => "replaced"}
    expected_result = "/test/replaced/file"

    assert_equal expected_result, HieraData::Interpolation.interpolate_facts(path: path, facts: facts)
  end

  test "::interpolate_facts replaces nested facts" do
    path = "/test/%{nested.fact}/file"
    facts = {"nested" => {"fact" => "deep"}}
    expected_result = "/test/deep/file"

    assert_equal expected_result, HieraData::Interpolation.interpolate_facts(path: path, facts: facts)
  end
end
