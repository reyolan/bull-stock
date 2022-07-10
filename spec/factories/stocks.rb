FactoryBot.define do
  factory :stock do
    association :user, factory: :approved_confirmed_trader
    symbol { 'TEST' }
    company_name { 'Test Company' }

    trait :with_quantity_unit_price do
      quantity { 12 }
      unit_price { 2 }
    end

    trait :with_amount do
      amount { 24 }
    end

    trait :another_symbol_company_name do
      symbol { 'ASD' }
      company_name { 'Asd Company' }
    end

    factory :valid_stock, traits: %i[with_quantity_unit_price with_amount]
    factory :stock_with_quantity_unit_price, traits: %i[with_quantity_unit_price]
    factory :another_valid_stock, traits: %i[with_quantity_unit_price with_amount another_symbol_company_name]
  end
end
