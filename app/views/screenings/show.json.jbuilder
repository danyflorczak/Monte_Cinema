# frozen_string_literal: true

json.screening do
  json.id @screening.id
  json.title @screening.movie.title
  json.hall @screening.hall.name
  json.start_time @screening.start_time
  json.available_seats do
    json.array! @screening.available_seats
  end
end
