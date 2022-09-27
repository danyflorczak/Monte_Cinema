# frozen_string_literal: true

module ApplicationHelper
  def date_to_hours(date)
    date.strftime('%H:%M')
  end

  def format_date(date)
    date.strftime('%d/%m/%Y %H:%M')
  end
end
