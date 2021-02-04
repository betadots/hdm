FactoryBot.define do
  factory :puppet_option, class: 'Puppet::Option' do
    name { "MyString" }
    slug { "MyString" }
    puppet_node { nil }
  end
end
