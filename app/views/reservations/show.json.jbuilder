json.reservation do
  json.id @reservation.id
  json.screening_id @reservation.screening_id
  json.email @reservation.email
  json.status @reservation.status
  # json.tickets do
  #   json.array! @reservation.tickets do |ticket|
  #     json.id ticket.id
  #     json.seat ticket.seat
  #   end
  # end
end