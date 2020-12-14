FactoryBot.define do
  factory :puppet_node do
    fqdn { "MyString" }
    role { "MyString" }
    puppet_environment { nil }
    zone { "MyString" }
    os_family { "MyString" }
    os_lsbdistcodename { "MyString" }
    organization { "MyString" }
    config_file_name { "MyString" }
  end
end
