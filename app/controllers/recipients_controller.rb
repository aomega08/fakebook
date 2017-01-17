class RecipientsController < ApplicationController
  def index
    if params[:name]
      @recipients = Recipient.find(params[:name])
      if @recipients.length > 0
        render :show
      else
        flash.now[:error] = I18n.t('recipients.index.error')
      end
    end
  end

  def new
    @recipient = Recipient.new
  end

  def create
    @recipient = Recipient.new(recipient_params)

    if @recipient.save
      redirect_to recipients_path(name: @recipient.name)
    else
      flash.now[:error] = I18n.t('recipients.create.error')
      render :new
    end
  end

  private

  def recipient_params
    params.require(:recipient).permit(:name)
  end
end
