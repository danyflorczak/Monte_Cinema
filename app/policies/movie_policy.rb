# frozen_string_literal: true

class MoviePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    manager?
  end

  def edit?
    manager?
  end

  def destroy?
    manager?
  end

  def create?
    manager?
  end

  def update?
    manager?
  end

  private

  def manager?
    user.role == "manager"
  end

  def client?
    user.role == "client"
  end
end
