FactoryBot.define do
  factory :book do
    factory :valid_book do
      genre { 'Dystopian' }
      author { 'Ray Bradbury' }
      image
      title { 'Fahrenheit 451' }
      publisher { 'Ballantine Books' }
      year { '1953' }
    end
  end
end
