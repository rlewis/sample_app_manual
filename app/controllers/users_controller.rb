class UsersController < ApplicationController
  def show
   @user = User.find(params[:id])
   @title = @user.name #automatically uses html_escape to avoid cross-site scripting attack
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
   @user = User.new(params[:user])
   if @user.save
      #handle successful save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
   else
      @title = "Sign up"
      render 'new'
   end
  end

end
