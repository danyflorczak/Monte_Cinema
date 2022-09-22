# frozen_string_literal: true

class ScreeningPolicy < ApplicationPolicy
  def index?
    manager?
  end

  def show?
    manager?
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
