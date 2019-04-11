FactoryBot.define do
  factory :book do
    genre { Faker::Book.genre }
    author { Faker::Book.author }
    image
    title { Faker::Book.title[0..24] }
    publisher { Faker::Book.publisher }
    year { Faker::Date.birthday.year }

    factory :book_with_rents do
      transient do
        rents_count { 5 }
      end

      after(:create) do |book, evaluator|
        create(:rent, book: book)
        create_list(:rent, evaluator.rents_count, :returned, book: book)
      end
    end
  end
end
