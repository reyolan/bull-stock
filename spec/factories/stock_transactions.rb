FactoryBot.define do
  factory :stock_transaction do
    association :user, factory: :approved_confirmed_trader
    amount { 250 }
    quantity { 12 }
    symbol { "TEST" }
    company_name { "Test Company" }
    unit_price { 144.12 }

    trait :buy_type do
      transaction_type { 0 }
    end

    trait :sell_type do
      transaction_type { 1 }
    end

    trait :yesterday_created do
      created_at { 1.day.ago }
      updated_at { 1.day.ago }
    end

    factory :buy_transaction, traits: %i[buy_type]
    factory :yesterday_buy_transaction, traits: %i[yesterday_created buy_type]
    factory :sell_transaction, traits: %i[sell_type]
    factory :yesterday_sell_transaction, traits: %i[yesterday_created sell_type]
  end
end
