FactoryBot.define do
  factory :puppet_configuration do
    name { "MyString" }
    slug { "MyString" }
    puppet_node_id { 1 }
    parent_id { 1 }
  end
end
