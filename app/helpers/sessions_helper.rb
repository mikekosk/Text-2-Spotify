module SessionsHelper

  # Receives Spotify Callback and Creates users
  def receive_spotify_callback
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @email = spotify_user.email
    @hash = spotify_user.to_hash
  end

  # Logs in the given user.
  def log_in(user, hash)
    puts 'log_in'
    puts user.id
    puts hash
    session[:user_id] = user.id
    session[:hash] = hash
  end

  # Logs out current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Create a new user
  def new_user(email)
    user = User.new(email: @email.downcase)
    user.save
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

end
