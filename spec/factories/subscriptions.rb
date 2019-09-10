FactoryBot.define do
  factory :subscription do
    trait :active do
      active { true }
    end

    trait :not_active do
      active { false }
    end

    trait :paused do
      active { false }
      paused { true }
    end
  end
end
