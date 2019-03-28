class RentSerializer < ActiveModel::Serializer
  attributes :id, :book_id, :user_id, :returned_at

  attribute :rented_from, key: :from
  attribute :rented_to, key: :to
end
