# frozen_string_literal: true

class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations
  before_validation :set_end_time, unless: :start_nil?
  validates :end_time, comparison: { greater_than: :start_time }
  validates :start_time, :end_time, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validate :used?

  def available_seats
    all_taken_seats = reservations.joins(:tickets).where.not(status: :cancelled).pluck(:'tickets.seat')
    hall.seats - all_taken_seats.flatten
  end

  def set_end_time
    self.end_time = start_time + movie.duration.minutes + ADS_TIME
  end

  def start_nil?
    start_time.nil?
  end

  def used?
    return if hall_available?

    errors.add(:start_time, 'Hall is used for another screening')
  end

  def hall_available?
    Screening
      .where(hall_id:)
      .where(end_time: start_time..end_time)
      .or(Screening.where(hall_id:)
      .where(start_time: start_time..end_time))
      .empty?
  end
end
