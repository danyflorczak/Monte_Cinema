class Movie < ApplicationRecord
    has_many :screenings
    has_many :halls, through: :screenings
end
