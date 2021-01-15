FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { "never-use-this-as-a-password" }
    password_digest { BCrypt::Password.create('secret') }
    association :role, factory: :role
  end
end
