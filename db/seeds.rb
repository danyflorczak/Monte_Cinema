# frozen_string_literal: true
require 'faker'

hall_capacities = [20,50,100,200]

10.times do
    Hall.create(
        name: Faker::FunnyName.name,
        capacity: hall_capacities[rand(4)]
    )
end
10.times do
    Movie.create(
        title: Faker::Movie.title,
        description:  Faker::Movie.quote,
        duration: rand(100) + 90
    )
end

100.times do
    Screening.create(
        movie_id: Movie.all.sample.id,
        hall_id: Hall.all.sample.id,
        start_time: DateTime.current.beginning_of_minute + rand(7).days + rand(24).hours + rand(60).minutes,
        price: rand(10) + 15
    )
end