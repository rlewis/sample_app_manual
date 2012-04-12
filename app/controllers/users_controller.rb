class UsersController < ApplicationController
  def show
   @user = User.find(params[:id])
   @title = @user.name #automatically uses html_escape to avoid cross-site scripting attack
   @time = @user.updated_at # Added for HW 9
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
   @user = User.new(params[:user])
   @remember = nil # Added for HW 9 - we assume that user will only remain signed in for the current session
   if @user.save
      #handle successful save
      sign_in @user, @remember # Added remember for HW
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
   else
      @title = "Sign up"
      render 'new'
   end
  end

end
