# frozen_string_literal: true

module ScreeningHelper
  def create_date_links
    content_tag(:ul, class: 'd-flex mb-3') do
      7.times do |num|
        concat(link_to((Time.zone.today + num.days).strftime('%d/%m'),
                       movies_path(start_time: Time.zone.today + num.days), class: 'mx-2'))
      end
    end
  end

  def which_day?(obj)
    link_date = params[:start_time] || DateTime.now.strftime('%Y-%m-%d')
    obj.start_time.strftime('%Y-%m-%d') == link_date
  end
end
