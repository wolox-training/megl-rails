require 'rails_helper'
require 'support/mocks_and_stubs/open_library_request_success'
require 'support/mocks_and_stubs/open_library_request_invalid'

describe OpenLibrary do
  context 'when a valid book is searched' do
    before do
      OpenLibraryRequestSuccess.call
    end

    let!(:result) { OpenLibrary.search('0385472579') }

    it 'makes an external request' do
      expect(WebMock).to have_requested(:get, OpenLibraryRequestSuccess.url)
    end

    it 'responds with the book' do
      expected = {
        isbn: '0385472579',
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
    before do
      OpenLibraryRequestInvalid.call
    end

    let!(:result) { OpenLibrary.search('13483783354345434') }

    it 'doesn\'t make an external request' do
      expect(WebMock).not_to have_requested(:get, OpenLibraryRequestInvalid.url)
    end

    it 'responds with an empty hash' do
      expect(result).to eq({})
    end
  end
end
