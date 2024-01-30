require 'test_helper'

class HieraData
  class InterpolationTest < ActiveSupport::TestCase
    test "::interpolate_globs handles globs" do
      datadir = Rails.root.join("test/fixtures/files/puppet/environments/globs/data")
      path = "common/*.yaml"
      expected_result = [
        "common/foobar.yaml",
        "common/hdm.yaml"
      ]

      assert_equal expected_result, HieraData::Interpolation.interpolate_globs(path:, datadir:)
    end

    test "::interpolate_facts replaces facts with leading colons" do
      path = "/test/%{::facts.test_fact}/file"
      facts = {"test_fact" => "replaced"}
      expected_result = "/test/replaced/file"

      assert_equal expected_result, HieraData::Interpolation.interpolate_facts(path:, facts:)
    end

    test "::interpolate_facts replaces facts without leading colons" do
      path = "/test/%{facts.test_fact}/file"
      facts = {"test_fact" => "replaced"}
      expected_result = "/test/replaced/file"

      assert_equal expected_result, HieraData::Interpolation.interpolate_facts(path:, facts:)
    end

    test "::interpolate_facts replaces facts with `trusted.` scope with leading colons" do
      path = "/test/%{::trusted.test_fact}/file"
      facts = {"trusted" => {"test_fact" => "replaced"}}
      expected_result = "/test/replaced/file"

      assert_equal expected_result, HieraData::Interpolation.interpolate_facts(path:, facts:)
    end

    test "::interpolate_facts replaces facts with `trusted.` scope without leading colons" do
      path = "/test/%{trusted.test_fact}/file"
      facts = {"trusted" => {"test_fact" => "replaced"}}
      expected_result = "/test/replaced/file"

      assert_equal expected_result, HieraData::Interpolation.interpolate_facts(path:, facts:)
    end

    test "::interpolate_facts replaces nested facts" do
      path = "/test/%{facts.nested.fact}/file"
      facts = {"nested" => {"fact" => "deep"}}
      expected_result = "/test/deep/file"

      assert_equal expected_result, HieraData::Interpolation.interpolate_facts(path:, facts:)
    end

    test "::interpolate_facts will not replace arbitrary variables with leading colons" do
      path = "/test/%{::test_fact}/file"
      facts = {"test_fact" => "replaced"}

      assert_equal path, HieraData::Interpolation.interpolate_facts(path:, facts:)
    end

    test "::interpolate_facts will not replace arbitrary variables without leading colons" do
      path = "/test/%{test_fact}/file"
      facts = {"test_fact" => "replaced"}

      assert_equal path, HieraData::Interpolation.interpolate_facts(path:, facts:)
    end
  end
end
