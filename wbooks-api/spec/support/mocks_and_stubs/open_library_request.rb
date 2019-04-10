module OpenLibraryMockRequest
  def self.call(isbn, body)
    WebMock.stub_request(:get, url(isbn))
           .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
           .to_return(
             status: 200,
             body: body,
             headers: { 'Content-Type': 'application/json' }
           )
  end

  def self.url(isbn)
    "https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data"
  end
end
