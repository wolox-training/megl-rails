ActiveAdmin.register BookSuggestion do
  permit_params :synopsis, :price, :author, :title, :link, :publisher, :year, :user_id
end
