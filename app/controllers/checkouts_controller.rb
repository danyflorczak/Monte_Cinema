# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer

    @checkout_session = current_user
      .payment_processor
      .checkout(
        mode: "payment",
        line_items: [{
          price_data: {
            currency: "pln",
            product_data: {
              name: "Film",
            },
            unit_amount: 300,
          },
          quantity: 1,
        }],
        success_url: checkout_success_url,
      )
  end

  def create
    session = Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "pln",
          product_data: {
            name: "Film",
          },
          unit_amount: 300,
        },
        quantity: 1,
      }],
      mode: "payment",
      success_url: "https://example.com/success",
      cancel_url: "https://example.com/cancel",
    })
    respond_to do |format|
      format.html
    end
  end

  def success; end
end
