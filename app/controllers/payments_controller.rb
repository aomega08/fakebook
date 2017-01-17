class PaymentsController < ApplicationController
  def index
    @payments = Payment.all
  end

  def new
    @payment = Payment.new
    @payment.recipient_id = params[:recipient_id] if params[:recipient_id]
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      redirect_to root_path
    else
      flash.now[:error] = "There were errors while creating the payment."
      render :new
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :currency, :recipient_id)
  end
end
