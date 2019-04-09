FactoryBot.define do
  factory :book_suggestion do
    synopsis { Faker::GreekPhilosophers.quote }
    price { Faker::Commerce.price }
    author { Faker::Book.author }
    title { Faker::Book.title }
    link { Faker::Internet.url }
    publisher { Faker::Book.publisher }
    year { Faker::Date.birthday.year }
    user
  end
end
