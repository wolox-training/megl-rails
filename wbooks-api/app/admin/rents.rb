ActiveAdmin.register Rent do
  permit_params :user_id, :book_id, :rented_from, :rented_to, :returned_at
end
