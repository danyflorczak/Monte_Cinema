# frozen_string_literal: true

class HallPolicy < ApplicationPolicy
  def index?
    manager?
  end

  def show?
    manager?
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
end
