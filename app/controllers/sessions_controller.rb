class SessionsController < ApplicationController

  def new
  end

  def create
    # puts params
    user = User.find_by_email(params[:user][:email])
    # puts user
    if user && user.authenticate(params[:user][:password])
      # puts "sure, yeah, no problem"
      session[:user_id] = user.id
      redirect_to '/'
    else
      # puts "nope"
      redirect_to '/'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
