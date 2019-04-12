# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50_000.times do
  Book.create(
    genre: Faker::Book.genre,
    author: Faker::Book.author,
    image: Image.new,
    title: Faker::Book.title[0..24],
    publisher: Faker::Book.publisher,
    year: Faker::Date.birthday.year
  )
end
