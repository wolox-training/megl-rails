require 'rails_helper'
require 'controllers/api/v1/authenticated_user'

describe Api::V1::BookSuggestionsController do
  include_context 'Authenticated User'
  include Response::JSONParser

  describe 'POST #create' do
    context 'When creating a valid book suggestion' do
      let!(:book_suggestion) { attributes_for(:book_suggestion) }

      it 'creates a new book suggestion' do
        expect do
          post :create, params: { book_suggestion: book_suggestion }
        end.to change { BookSuggestion.count }.by(1)
      end

      it 'responds with 201 status' do
        post :create, params: { book_suggestion: book_suggestion }
        expect(response).to have_http_status(:created)
      end
    end

    context 'When creating an invalid book suggestion' do
      let!(:book_suggestion) { attributes_for(:book_suggestion, title: nil) }

      before do
        post :create, params: { book_suggestion: book_suggestion }
      end

      it 'doesn\'t create a new book suggestion' do
        expect do
          post :create, params: { book_suggestion: book_suggestion }
        end.to change { BookSuggestion.count }.by(0)
      end

      it 'responds with 400 status' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
