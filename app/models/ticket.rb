# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :reservations
  validates :seat, presence: true
end
