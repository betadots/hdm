require 'test_helper'

class HieraData::DataFileTest < ActiveSupport::TestCase
  class GitIntegration < ActiveSupport::TestCase
    DATADIR = Rails.root.join('test', 'fixtures', 'files', 'puppet', 'environments', 'development', 'data')
    PATH = DATADIR.join('nodes', 'writehost.yaml')

    setup do
      Rails.configuration.hdm["git_data"] = [
        {
          datadir: DATADIR.to_s,
          path_in_repo: "/",
          git_url: "git@example.com/example.git"
        }
      ]
    end

    teardown do
      Rails.configuration.hdm["git_data"] = nil
    end

    test "#write_key triggers git commit" do
      git_repo = MiniTest::Mock.new
      git_repo.expect(:local_path, DATADIR)
      git_repo.expect(:commit!, true, [:add, PATH])
      HieraData::GitRepo.stub(:new, git_repo) do
        with_temp_file(PATH) do
          expected_hash = {"test_key"=>"true"}
          file = HieraData::DataFile.new(path: PATH)
          file.write_key('test_key', 'true')
          assert_equal expected_hash, YAML.load(File.read(PATH))
        end
      end
      git_repo.verify
    end

    test "#remove_key triggers git commit" do
      git_repo = MiniTest::Mock.new
      git_repo.expect(:local_path, DATADIR)
      git_repo.expect(:commit!, true, [:remove, PATH])
      HieraData::GitRepo.stub(:new, git_repo) do
        with_temp_file(PATH) do
          File.write(PATH, {"test_key" => true}.to_yaml)
          expected_hash = {}
          file = HieraData::DataFile.new(path: PATH)
          file.remove_key('test_key')
          assert_equal expected_hash, YAML.load(File.read(PATH))
        end
      end
      git_repo.verify
    end
  end
end
