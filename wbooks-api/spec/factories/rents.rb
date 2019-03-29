FactoryBot.define do
  factory :rent do
    user { User.find_by(email: 'test@wolox.com.ar') }
    book
    rented_from { Faker::Date.backward(10) }
    rented_to { Faker::Date.forward(10) }

    trait :returned do
      returned_at { Faker::Date.forward(3) }
    end
  end
end
