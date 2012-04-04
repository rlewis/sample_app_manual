class UsersController < ApplicationController
  def show
	@user = User.find(params[:id])
	@title = @user.name #automatically uses html_escape to avoid cross-site scripting attack
  end
  
  def new
    @title = "Sign up"
  end

end
