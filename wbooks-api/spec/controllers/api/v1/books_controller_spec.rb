require 'rails_helper'
require 'controllers/api/v1/authenticated_user'

describe Api::V1::BooksController do
  include_context 'Authenticated User'
  include Response::JSONParser

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

        expect(expected).to eq response_body['page']
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

        expect(expected).to eq response_body
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when fetching an invalid book' do
      before do
        get :show, params: { id: 1 }
      end

      it 'responds with 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET #search' do
    book = {
      isbn: '0385472579',
      title: 'Zen speaks',
      subtitle: 'shouts of nothingness',
      number_of_pages: 159,
      authors: [
        'Zhizhong Cai'
      ]
    }

    before do
      open_library = class_double('OpenLibrary').as_stubbed_const
      allow(open_library).to receive(:search).with('0385472579').and_return(book)
      allow(open_library).to receive(:search).with('13483783354345434').and_return({})
    end

    context 'when searching a valid book' do
      before do
        get :search, params: { isbn: '0385472579' }
      end

      it 'responses with the book' do
        expect(book.stringify_keys).to eq response_body
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when fetching an invalid book' do
      before do
        get :search, params: { isbn: '13483783354345434' }
      end

      it 'responds with 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
