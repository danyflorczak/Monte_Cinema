# frozen_string_literal: true

class PromotionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @promotions = Promotion.all
  end

  private

  def hall_params
    params.require(:promotion).permit(:value, :description)
  end
end
