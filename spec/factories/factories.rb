FactoryBot.define do
    factory :user do
        sequence(:email) {|n| "test-#{n.to_s.rjust(3,"1")}@sample.com"}
        password {"abc123"}
        password_confirmation {"abc123"}
        role {0}
    end
end
