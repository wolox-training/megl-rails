class Book < ApplicationRecord
  validates :genre, :author, :image, :title, :editor, :year, presence: true

  has_many :rents, dependent: :destroy
end
