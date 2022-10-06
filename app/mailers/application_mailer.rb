# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'monte@cinema.com'
  layout 'mailer'
end
