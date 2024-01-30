require 'test_helper'

class HieraData
  class GitRepoTest < ActiveSupport::TestCase
    test "#initialize raises when given invalid git uri" do
      assert_raises(Hdm::Error) do
        HieraData::GitRepo.new("git@://invalid_uri")
      end
    end

    test "#intialize raises when given a non-existant repo" do
      assert_raises(Hdm::Error) do
        HieraData::GitRepo.new("git@example.invalid:repost/test.git")
      end
    end
  end
end
