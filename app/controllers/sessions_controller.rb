class SessionsController < Devise::SessionsController
  before_filter :update_user, only: [:destroy]
  
  def destroy
    puts  resource
    super
  end

  private

  def update_user
    user = User.find(session[:usr_id])
    user.update(:twillio_verification_code => nil, :is_twillio_verified => false)
    session.delete(:usr_id)
  end
end
