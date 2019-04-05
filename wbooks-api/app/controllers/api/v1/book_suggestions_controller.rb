module Api
  module V1
    class BookSuggestionsController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        book_suggestion = BookSuggestion.new(book_suggestion_params)

        return head(:bad_request) unless book_suggestion.save

        render json: book_suggestion, status: :created
      end

      private

      def book_suggestion_params
        params.require(:book_suggestion).permit(:synopsis, :price, :author, :title, :link,
                                                :publisher, :year, :user_id)
      end
    end
  end
end
