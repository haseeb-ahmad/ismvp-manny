class TwillioConfirmationsController < ApplicationController
  include MessageSender
  
  def new
  	puts "++++++++++++ session +++++++++++#{params[:user_id]}++++++++\n"*10
  	puts params[:user_id]
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find params[:user_id]
    if @user.twillio_verification_code == params[:verification_code].to_i
      # @user.confirm!
      # session[:authenticated] = true

      @user.update_columns(:twillio_verification_code => nil, :is_twillio_verified => true)

      flash[:notice] = "Welcome! You successfully authenticated!"
      redirect_to dashboard_users_path
    else
      flash.now[:error] = "Verification code is incorrect."
      render :new
    end
  end

  def check_number
    valid =  MessageSender.valid(params[:phone_number])
    if valid
      render :json  => { valid: true } 
    else
      render :json  => { valid: false }
    end
  end

end