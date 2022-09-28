# frozen_string_literal: true

require 'faker'

hall_capacities = [20, 50, 100, 200]

10.times do
  Hall.create(
    name: Faker::FunnyName.name,
    capacity: hall_capacities.sample
  )
end
10.times do
  Movie.create(
    title: Faker::Movie.title,
    description: Faker::Movie.quote,
    duration: rand(90..189)
  )
end

100.times do
  Screening.create(
    movie_id: Movie.all.sample.id,
    hall_id: Hall.all.sample.id,
    start_time: rand(DateTime.current..DateTime.current + 7.days),
    price: rand(15..24)
  )
end
