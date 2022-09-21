# frozen_string_literal: true

module ApplicationHelper
  def format_date(date)
    date.strftime('%d/%m/%Y %H:%M')
  end
end
