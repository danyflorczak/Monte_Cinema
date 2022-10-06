json.movie do
  json.id @movie.id
  json.title @movie.title
  json.description @movie.description
  json.duration @movie.duration
  json.screenings do
    json.array! @screenings do |screening|
      if screening.movie_id == @movie.id
        json.id screening.id
        json.start_time screening.start_time
        json.end_time screening.end_time
        json.price screening.price
      end
    end
  end
end