FactoryBot.define do
  factory :rent do
    user { nil }
    book { nil }
    borrowed_at { '2019-03-27' }
    returned_at { '2019-03-27' }
  end
end
