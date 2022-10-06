json.screening do
  json.id @screening.id
  json.title @screening.movie.title
  json.hall @screening.hall.name
  json.start_time @screening.start_time
  json.available seats do
    json.array! @screening.availabe_seats, :seat
  end
end