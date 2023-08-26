# frozen_string_literal: true

module ScreeningHelper
  DAYS_NUMBER = 7
  def create_date_links
    content_tag(:ul, class: "d-flex mb-3 date-links") do
      DAYS_NUMBER.times do |num|
        concat(link_to((Time.zone.today + num.days).strftime("%a %d/%m"),
          request.params.merge(start_time: Time.zone.today + num.days), class: "mx-2 p-4 fs-5 fw-normal",))
      end
    end
  end

  def which_day?(screening)
    link_date = params[:start_time] || DateTime.now.strftime("%Y-%m-%d")
    screening.start_time.strftime("%Y-%m-%d") == link_date
  end
end
