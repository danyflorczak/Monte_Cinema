# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'danyflorczak@gmail.com'
  layout 'mailer'
end
