FactoryBot.define do
  factory :balance_transaction do
    association :user, factory: :approved_confirmed_trader
    amount { 250 }

    trait :deposit_type do
      transaction_type { 0 }
    end

    trait :withdraw_type do
      transaction_type { 1 }
    end

    trait :yesterday_created do
      created_at { 1.day.ago }
      updated_at { 1.day.ago }
    end

    factory :deposit_transaction, traits: %i[deposit_type]
    factory :yesterday_deposit_transaction, traits: %i[yesterday_created deposit_type]
    factory :withdraw_transaction, traits: %i[withdraw_type]
    factory :yesterday_withdraw_transaction, traits: %i[yesterday_created withdraw_type]
  end
end
