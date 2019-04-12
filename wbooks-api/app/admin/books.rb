ActiveAdmin.register Book do
  permit_params :genre, :author, :title, :publisher, :year, :image_id
end
