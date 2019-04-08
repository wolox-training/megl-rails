FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'testtest' }
    password_confirmation { 'testtest' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:name) { |n| "User #{n}" }

    factory :admin do
      admin { true }
    end
  end
end
