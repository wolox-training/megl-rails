module Api
  module V1
    class BooksController < ApiController
      def index
        render_paginated Book.all, each_serializer: BookIndexSerializer
      end

      def show
        render json: Book.find(params[:id]), serializer: BookShowSerializer
      end
    end
  end
end
