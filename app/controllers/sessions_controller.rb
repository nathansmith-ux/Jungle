class SessionsController < ApplicationController
  def new
  end

  def create
    if user && User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Login Successful"
      redirect_to '/'
    else
      flash[:notice] = "Invalid Email Or Password"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged Out"
    redirect_to '/login'
  end
end
