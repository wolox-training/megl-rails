FactoryBot.define do
  factory :rent do
    user { nil }
    book { nil }
    rented_from { '2019-03-27' }
    rented_to { '2019-03-27' }
    returned_at { '2019-03-27' }
  end
end
