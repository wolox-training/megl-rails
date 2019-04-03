class Book < ApplicationRecord
  validates :genre, :author, :title, :publisher, :year, presence: true

  has_many :rents, dependent: :destroy
  belongs_to :image
end
