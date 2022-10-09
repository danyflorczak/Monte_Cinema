# frozen_string_literal: true

class PromotionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @promotions = policy_scope(Promotion).all
  end
end
