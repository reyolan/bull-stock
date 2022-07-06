FactoryBot.define do
    factory :user do
        password { "password" }
        password_confirmation { "password" }
        confirmed_at { Time.now }
        
        trait :admin do
            email { Faker::Internet.email }
            role { 0 }
        end
        
        trait :trader do
            email { Faker::Internet.email }
            role { 1 }
        end        

    factory :admin,    traits: [:admin]
    factory :trader,   traits: [:trader]
    end
end