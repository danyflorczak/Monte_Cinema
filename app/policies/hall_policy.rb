# frozen_string_literal: true

class HallPolicy < ApplicationPolicy
  def create?
    manager?
  end

  def update?
    manager?
  end

  private

  def manager?
    user.role == 'manager'
  end
end
