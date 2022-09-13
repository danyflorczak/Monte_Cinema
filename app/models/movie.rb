class Movie < ApplicationRecord
    has_many :screenings
    has_many :halls, through: :screenings
    validates :title, :duration, presence: true
    validates :duration, numericality: { greater_than: 0 }
end
