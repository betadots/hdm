FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "Group#{n}" }

    trait :environment do
      restrict { "environment" }
    end

    trait :node do
      restrict { "node" }
    end

    trait :key do
      restrict { "key" }
    end
  end
end
