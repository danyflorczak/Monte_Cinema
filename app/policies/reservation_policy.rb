# frozen_string_literal: true

class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == 'manager'
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def index?
    true
  end

  def new?
    manager? || client?
  end

  def edit?
    manager?
  end

  def destroy?
    manager?
  end

  def create?
    manager? || client?
  end

  def create_at_desk?
    manager?
  end

  def update?
    manager?
  end

  private

  def manager?
    user.role == 'manager'
  end

  def client?
    user.role == 'client'
  end
end
