class Rent < ApplicationRecord
  validates :user, :book, :rented_from, :rented_to, presence: true

  belongs_to :user
  belongs_to :book

  def active?
    returned_at.blank?
  end
end
