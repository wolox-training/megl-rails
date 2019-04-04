class OpenLibrary
  def self.valid_isbn?(isbn)
    (isbn.length == 10 || isbn.length == 13) && isbn.scan(/\D/).empty?
  end

  def self.search(isbn)
    return {} unless valid_isbn?(isbn)

    response = HTTParty.get("https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}"\
                            '&format=json&jscmd=data')

    return {} if response.empty?

    response = response.values[0]

    { isbn: isbn,
      title: response['title'],
      subtitle: response['subtitle'],
      number_of_pages: response['number_of_pages'],
      authors: response['authors'].map { |a| a['name'] } }
  end
end
