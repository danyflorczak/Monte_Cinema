# frozen_string_literal: true

class PromotionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
end
