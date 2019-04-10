module OpenLibraryRequestInvalid
  def self.call
    WebMock.stub_request(:get, url)
           .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
           .to_return(
             status: 200,
             body: '{}',
             headers: { 'Content-Type': 'application/json' }
           )
  end

  def self.url
    "#{Rails.application.secrets.open_library_api}books?bibkeys=ISBN:13483783354345434" \
    '&format=json&jscmd=data'
  end
end
