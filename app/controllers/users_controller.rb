class UsersController < ApplicationController



  def spotify

    # Authenticate User
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new()    # Not the final implementation!
    if @user.save
      # Handle a successful save.
    else
      render 'new'
    end
  end

end
