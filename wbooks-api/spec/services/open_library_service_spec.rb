require 'rails_helper'
require 'support/mocks_and_stubs/open_library_request'

describe OpenLibrary do
  context 'when a valid book is searched' do
    let!(:isbn) { '0385472579' }

    before do
      file_path = './spec/support/fixtures/open_library_response_success.json'

      OpenLibraryMockRequest.call(isbn, File.read(file_path))
    end

    let!(:result) { OpenLibrary.search(isbn) }

    it 'makes an external request' do
      expect(WebMock).to have_requested(:get, OpenLibraryMockRequest.url(isbn))
    end

    it 'responds with the book' do
      expected = {
        isbn: isbn,
        title: 'Zen speaks',
        subtitle: 'shouts of nothingness',
        number_of_pages: 159,
        authors: [
          'Zhizhong Cai'
        ]
      }

      expect(result).to eq expected
    end
  end

  context 'when an invalid book is searched' do
    let!(:isbn) { '13483783354345434' }

    before do
      OpenLibraryMockRequest.call(isbn, '{}')
    end

    let!(:result) { OpenLibrary.search(isbn) }

    it 'doesn\'t make an external request' do
      expect(WebMock).not_to have_requested(:get, OpenLibraryMockRequest.url(isbn))
    end

    it 'responds with an empty hash' do
      expect(result).to eq({})
    end
  end
end
