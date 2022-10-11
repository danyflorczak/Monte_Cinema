# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationCancelJob, type: :job do
  describe 'cancel job perform later' do
    it 'enqueues job' do
      ActiveJob::Base.queue_adapter = :test
      expect { described_class.perform_later }.to have_enqueued_job
    end
  end
end
