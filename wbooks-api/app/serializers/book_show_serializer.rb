class BookShowSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :publisher, :year, :image_url, :genre, :actual_rent

  def image_url
    object.image.url.to_s
  end

  def actual_rent
    RentSerializer.new(object.active_rent).as_json if object.active_rent
  end
end
