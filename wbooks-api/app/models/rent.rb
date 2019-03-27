class Rent < ApplicationRecord
  validates :user, :book, :borrowed_at, :returned_at, presence: true

  belongs_to :user
  belongs_to :book
end
