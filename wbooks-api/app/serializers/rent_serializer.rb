class RentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :book_id, :rented_from, :rented_to, :returned_at, :created_at,
             :updated_at
end
