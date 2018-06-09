class SessionsController < ApplicationController

  def create
    receive_spotify_callback
    user = User.find_by(email: @email.downcase)
    if user
      log_in(user, @hash)
    else
      new_user(@email)
      user = User.find_by(email: @email.downcase)
      log_in(user, @hash)
    end
    redirect_to user
  end

  def destroy
    @user = User.find_by(id: session[:user_id])
    log_out
    redirect_to root_url
  end

end
