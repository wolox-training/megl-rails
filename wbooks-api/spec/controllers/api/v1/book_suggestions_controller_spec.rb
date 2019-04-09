require 'rails_helper'
require 'controllers/api/v1/authenticated_user'

describe Api::V1::BookSuggestionsController do
  include_context 'Authenticated User'
  include Response::JSONParser

  describe 'POST #create' do
    subject(:http_request) { post :create, params: { book_suggestion: book_suggestion } }

    context 'When creating a valid book suggestion' do
      let!(:book_suggestion) { attributes_for(:book_suggestion) }

      it 'creates a new book suggestion' do
        expect { http_request }.to change { BookSuggestion.count }.by(1)
      end

      it { is_expected.to have_http_status(:created) }
    end

    context 'When creating an invalid book suggestion' do
      let!(:book_suggestion) { attributes_for(:book_suggestion, title: nil) }

      it 'doesn\'t create a new book suggestion' do
        expect { http_request }.to change { BookSuggestion.count }.by(0)
      end

      it { is_expected.to have_http_status(:bad_request) }
    end
  end
end
