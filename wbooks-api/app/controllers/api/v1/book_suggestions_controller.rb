module Api
  module V1
    class BookSuggestionsController < ApplicationController
      def create
        book_suggestion = BookSuggestion.new(book_suggestion_params)

        unless book_suggestion.save
          head :bad_request
          return
        end

        render json: book_suggestion, status: :created, serializer: BookSuggestionSerializer
      end

      private

      def book_suggestion_params
        params.require(:book_suggestion).permit(:synopsis, :price, :author, :title, :link,
                                                :publisher, :year, :user_id)
      end
    end
  end
end
