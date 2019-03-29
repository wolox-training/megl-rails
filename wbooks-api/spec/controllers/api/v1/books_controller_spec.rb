require 'rails_helper'
require 'controllers/api/v1/authenticated_user'

describe Api::V1::BooksController do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'when fetching all the books' do
      let!(:books) { create_list(:book_with_rents, 3) }

      before do
        get :index
      end

      it 'responses with all the books' do
        expected = JSON.parse(ActiveModel::Serializer::CollectionSerializer.new(
          books, serializer: BookIndexSerializer
        ).to_json)

        content = JSON.parse(response.body)['page']

        expect(content).to eq expected
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'when fetching a book' do
      let!(:book) { create(:book_with_rents) }

      before do
        get :show, params: { id: book.id }
      end

      it 'responses with the book' do
        expected = JSON.parse(BookShowSerializer.new(
          book
        ).to_json)

        content = JSON.parse(response.body)
        expect(expected).to eq content
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
