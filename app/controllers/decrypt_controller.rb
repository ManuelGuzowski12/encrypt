class DecryptController < ApplicationController
  def index
  end
  def show
    @message = Message.find(params[:message][:id])
    salt  = SecureRandom.random_bytes(64)
    key = ActiveSupport::KeyGenerator.new(params[:message][:secret_key]).generate_key(salt)
    encrypt = ActiveSupport::MessageEncryptor.new(key)
    params[:message][:secret_key] = encrypt.encrypt_and_sign(params[:message][:secret_key])
    if params[:message][:secret_key] == @message.secret_key
      @secret = encrypt.decrypt_and_verify(@message.content)
    else
      @lol = 'no existe'
    end
  end
end
