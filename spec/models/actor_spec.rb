require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe "associations" do
    it { is_expected.to have_and_belongs_to(:screenings) }
  end
end
