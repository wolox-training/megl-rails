class Image < ApplicationRecord
  has_one :book, dependent: :destroy
end
