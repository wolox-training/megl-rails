class Rent < ApplicationRecord
  validates :user, :book, :rented_from, :rented_to, presence: true

  scope :active, -> { where(returned_at: [nil, '']) }
  scope :expired, -> { active.where(rented_to: Date.today) }

  belongs_to :user
  belongs_to :book
end
