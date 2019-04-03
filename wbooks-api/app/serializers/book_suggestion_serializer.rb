class BookSuggestionSerializer < ActiveModel::Serializer
  attributes :id, :synopsis, :price, :author, :title, :link, :publisher, :year, :user_id,
             :created_at, :updated_at
end
