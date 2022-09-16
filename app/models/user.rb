# frozen_string_literal: true

class User < ApplicationRecord
  enum role: { client: 0, management: 1 }
end
