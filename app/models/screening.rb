# frozen_string_literal: true

class Screening < ApplicationRecord
  belongs_to :movie
  belongs_to :hall
  has_many :reservations, dependent: :destroy

  validates :start_time, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validate :used?

  def all_taken_seats
    reservations.joins(:tickets).where.not(status: :cancelled).pluck(:'tickets.seat')
  end

  def available_seats
    hall.seats - all_taken_seats.flatten
  end

  def set_end_time
    return unless start_time_changed?

    self.end_time = start_time + movie.duration.minutes + ADS_TIME
  end

  def start_nil?
    start_time.nil?
  end

  def time_range
    start_time..end_time
  end

  def used?
    errors.add(:base, "Hall is already used for another screening") if overlaps?
  end

  private

  def overlaps?
    Screening.where(hall_id:).where.not(id:).any? do |screening|
      time_range.overlaps?(screening.time_range)
    end
  end
end
