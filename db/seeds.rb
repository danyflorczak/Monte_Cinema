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
    genre: Faker::Book.genre,
    director: Faker::Name.name,
    release_date: Faker::Date.between(from: 20.years.ago, to: Date.today),
  )
  
  rand(1..5).times do
    actor = Actor.create(
      name: Faker::Name.name
    )
    
    Role.create(
      name: "Some Role",
      actor: actor,
      movie: movie
    )
  end
  
  image_url = Faker::LoremFlickr.image.to_s
  filename = File.basename(image_url)
  file = URI.open(image_url)
  movie.poster_image.attach(io: file, filename: filename)
end

200.times do
  screening_start_time = DateTime.current.beginning_of_minute + rand(7).days + rand(24).hours + rand(60).minutes
  Screening.create(
    movie_id: Movie.all.sample.id,
    hall_id: Hall.all.sample.id,
    start_time: screening_start_time,
    end_time: screening_start_time + 120.minutes,
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
