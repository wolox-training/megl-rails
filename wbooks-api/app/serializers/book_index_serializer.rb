class BookIndexSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :publisher, :year, :genre, :created_at, :updated_at

  belongs_to :image
end
