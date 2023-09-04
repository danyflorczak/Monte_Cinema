# frozen_string_literal: true

class Role < ApplicationRecord
  belongs_to :actor
  belongs_to :movie
end
