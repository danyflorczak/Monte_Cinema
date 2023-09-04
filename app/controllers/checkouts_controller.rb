class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer

    @checkout_session = current_user
          .payment_processor
          .checkout(
            mode: "payment",
            line_items: "price_1NmXHaLHG4welAl56nzmBuV0",
            success_url: checkout_success_url,
          )
  end

  def success

  end
end
