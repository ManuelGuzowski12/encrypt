class MessagesController < ApplicationController

  before_action :require_user, only: [:index, :new, :create, :show]
  def index
    @messages = Message.all
  end
  def new
    @message = Message.new
  end
  def create
   @message = Message.new(message_params)
   if @message.save
     redirect_to'/messages'
   else
     render 'new'
   end
 end
 def show
   @message = Message.find(params[:id])
 end

 private
   def message_params
     salt  = SecureRandom.random_bytes(64)
     key = ActiveSupport::KeyGenerator.new(params[:message][:secret_key]).generate_key(salt)
     encrypt = ActiveSupport::MessageEncryptor.new(key)
     params[:message][:secret] = params[:message][:content]
     params[:message][:content] = encrypt.encrypt_and_sign(params[:message][:content])
     params.require(:message).permit(:title,:content, :secret_key, :secret)
   end
end
