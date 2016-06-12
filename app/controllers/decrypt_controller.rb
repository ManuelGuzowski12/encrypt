class DecryptController < ApplicationController
  def index
  end
  def show
    @message = Message.find(params[:message][:id])
    if params[:message][:secret_key] == @message.secret_key
      @secret = @message.secret
    else
      redirect_to '/error'
    end
  end
end
