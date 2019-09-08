class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_back_or current_user
      # redirect_back_or 'static_pages/home'
    end
  end

  def create
  	user = User.find_by_email(params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
      flash.now[:error] = 'Please confirm your email address by following the instructions in the account confirmation email you received to proceed' if not user.email_confirmed
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or root_path
  	else
  		flash.now[:danger] = "Invalid credentials"
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
