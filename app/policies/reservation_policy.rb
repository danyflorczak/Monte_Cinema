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
    manager? || client?
  end

  def new?
    true
  end

  def cancel?
    client?
  end

  def confirm?
    manager?
  end

  def create?
    client? || manager?
  end

  def create_without_registration?
    true
  end

  def create_at_desk?
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
