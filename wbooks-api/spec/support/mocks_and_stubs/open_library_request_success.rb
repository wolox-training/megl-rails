module OpenLibraryRequestSuccess
  def self.call
    WebMock.stub_request(:get, url)
           .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
           .to_return(
             status: :ok,
             body: File.read('./spec/support/fixtures/open_library_response_success.json'),
             headers: { 'Content-Type': 'application/json' }
           )
  end

  def self.url
    'https://openlibrary.org/api/books?bibkeys=ISBN:0385472579&format=json&jscmd=data'
  end
end
