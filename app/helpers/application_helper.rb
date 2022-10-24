# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def date_to_hours(date)
    date.strftime("%H:%M")
  end

  def format_date(date)
    date.strftime("%d/%m/%Y %H:%M")
  end

  def manager?
    current_user.role == "manager"
  end

  def client?
    current_user.role == "client"
  end
end
