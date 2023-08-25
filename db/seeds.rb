# frozen_string_literal: true

require "faker"
require "open-uri"

hall_capacities = [20, 50, 100, 200]
10.times do
  Hall.create(
    name: Faker::FunnyName.name,
    capacity: hall_capacities.sample,
  )
end
10.times do
  movie = Movie.create(
    title: Faker::Movie.title,
    description: Faker::Movie.quote,
    duration: rand(90..189),
  )
  image_url = Faker::LoremFlickr.image.to_s
  filename = File.basename(image_url)
  file = URI.open(image_url)
  movie.poster_image.attach(io: file, filename:)
end

800.times do
  Screening.create(
    movie_id: Movie.all.sample.id,
    hall_id: Hall.all.sample.id,
    start_time: DateTime.current.beginning_of_minute + rand(7).days + rand(24).hours + rand(60).minutes,
    price: rand(15..24),
  )
end

manager = User.new(
  email: "test@manager.com",
  password: "password",
  role: "manager",
)
manager.save!

client = User.new(
  email: "test@client.com",
  password: "password",
  role: "client",
)
client.save!
