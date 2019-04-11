class Rent < ApplicationRecord
  validates :user, :book, :rented_from, :rented_to, presence: true

  scope :active, -> { where(returned_at: [nil, '']) }
  scope :expired, -> { active.where(rented_to: Time.zone.today) }

  belongs_to :user
  belongs_to :book
end
