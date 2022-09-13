class Hall < ApplicationRecord
    has_many :screenings
    has_many :movies, through: :screenings
end
