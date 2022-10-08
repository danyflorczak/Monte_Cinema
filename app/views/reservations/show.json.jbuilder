# frozen_string_literal: true

json.reservation do
  json.id @created_reservation.id
  json.screening_id @created_reservation.screening_id
  json.email @created_reservation.email
  json.status @created_reservation.status
  json.tickets @created_reservation.tickets do |ticket|
    json.id ticket.id
    json.seat ticket.seat
  end
end
