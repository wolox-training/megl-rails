module Api
  module V1
    class BooksController < ApiController
      def index
        books = Book.all
        render_paginated books, each_serializer: BookIndexSerializer
      end

      def show
        book = Book.find(params[:id])
        render json: book, serializer: BookShowSerializer
      end
    end
  end
end
