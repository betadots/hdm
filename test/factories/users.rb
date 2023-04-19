FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { "password" }

    trait :admin do
      role { "admin" }
    end

    trait :api do
      role { "api" }
    end
  end
end
