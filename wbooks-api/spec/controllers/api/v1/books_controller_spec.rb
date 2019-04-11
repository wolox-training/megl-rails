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
    let!(:isbn) { '0385472579' }
    let!(:invalid_isbn) { '13483783354345434' }

    let!(:book) do
      {
        isbn: isbn,
        title: Faker::Book.title,
        subtitle: Faker::GreekPhilosophers.quote,
        number_of_pages: Faker::Number.number(3),
        authors: [
          Faker::Book.author
        ]
      }
    end

    before do
      open_library = class_double('OpenLibrary').as_stubbed_const
      allow(open_library).to receive(:search).with(isbn).and_return(book)
      allow(open_library).to receive(:search).with(invalid_isbn).and_return({})
    end

    context 'when searching a valid book' do
      before do
        get :search, params: { isbn: isbn }
      end

      it 'responses with the book' do
        expect(book.stringify_keys).to eq response_body
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when fetching an invalid book' do
      subject(:http_request) { get :search, params: { isbn: invalid_isbn } }

      it { is_expected.to have_http_status(:not_found) }
    end
  end
end
