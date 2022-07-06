FactoryBot.define do
  factory :balance_transaction do
    association :user, factory: :approved_confirmed_trader
    amount { 250 }

    factory :deposit_transaction do
      transaction_type { 0 }
    end

    factory :withdraw_transaction do
      transaction_type { 1 }
    end
  end
end
