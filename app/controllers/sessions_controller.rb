class SessionsController < ApplicationController

  # before_action :spotify

  def new
  end

  def create
    receive_spotify_callback
    user = User.find_by(email: @email.downcase)
    if user
      puts 'it worked!'
      log_in(user, @hash)
    else
      puts 'it didnt work'
      new_user(@email)
      log_in(user, @hash)
    end
    flash[:success] = 'Welcome!'
    redirect_to user
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

    # def spotify
    #   spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    #   @email = spotify_user.email
    #   @hash = spotify_user.to_hash
    # end

end
