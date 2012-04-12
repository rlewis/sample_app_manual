class SessionsController < ApplicationController
  def new
    @title = "Sign in" # As required by spec test
  end
  
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    remember = params[:remember_me] # Added for HW 9
    if user.nil?
        flash.now[:error] = "Invalid email/password combination."
        @title = "Sign in"
        render 'new'
    else
        # Sign the user in and redirect to the user's show page
        sign_in user, remember
        redirect_to user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
  def update_login(user)
    user.last_login_at = Time.new.utc
    user.save!
  end
end
