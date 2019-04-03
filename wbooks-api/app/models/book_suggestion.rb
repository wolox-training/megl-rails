class BookSuggestion < ApplicationRecord
  validates :author, :title, :link, :publisher, :year, presence: true

  belongs_to :user, optional: true
end
