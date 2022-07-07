FactoryBot.define do
  factory :user do
    password { 'password' }
    password_confirmation { 'password' }

    trait :approved do
      approved { true }
    end

    trait :unapproved do
      approved { false }
    end

    trait :confirmed do
      confirmed_at { Time.now }
    end

    trait :with_balance do
      balance { 123_456 }
    end

    trait :admin_email_role do
      email { Faker::Internet.email(name: 'admin') }
      role { 0 }
    end

    trait :trader_email_role do
      email { Faker::Internet.email(name: 'trader') }
      role { 1 }
    end

    factory :admin, traits: %i[approved confirmed admin_email_role]
    factory :approved_confirmed_trader, traits: %i[approved confirmed trader_email_role]
    factory :unapproved_confirmed_trader, traits: %i[unapproved confirmed trader_email_role]
    factory :unapproved_unconfirmed_trader, traits: %i[unapproved trader_email_role]
    factory :trader_with_balance, traits: %i[approved confirmed trader_email_role with_balance]
  end
end
