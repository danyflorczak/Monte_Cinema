# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'https://monte-cinema-v1.herokuapp.com/'
  layout 'mailer'
end
