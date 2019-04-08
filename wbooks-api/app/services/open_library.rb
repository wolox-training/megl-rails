class OpenLibrary
  def self.valid_isbn?(isbn)
    (isbn.length == 10 || isbn.length == 13) && isbn.scan(/\D/).empty?
  end

  def self.build_response(response)
    { isbn: response['identifiers']['isbn_10'].first,
      title: response['title'],
      subtitle: response['subtitle'],
      number_of_pages: response['number_of_pages'],
      authors: response['authors'].map { |a| a['name'] } }
  end

  def self.search(isbn)
    isbn.freeze

    return {} unless valid_isbn?(isbn)

    response = HTTParty.get("https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}"\
                            '&format=json&jscmd=data').values

    return {} if response.empty?

    response.empty? ? {} : build_response(response[0])
  end
end
