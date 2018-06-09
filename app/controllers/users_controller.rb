class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    spotify_user = RSpotify::User.new(session[:hash])
    session[:user_id] = params[:id]

    ## Select Playlist
    if params[:playlist_id]

      ## Pull and save current playlist ID
      playlist_id = params[:playlist_id].to_i - 1
      session[:playlist_id] = playlist_id
      @user.update(playlist_id: playlist_id)

      ## Select 50 most recent songs in playlist
      playlist_size = spotify_user.playlists[playlist_id].total
      if playlist_size > 50
        offset_value = playlist_size - 50
      else
        offset_value = 0
      end
      @tracks = spotify_user.playlists[playlist_id].tracks(limit: 50, offset: offset_value).reverse
      
    else
      @tracks = nil
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    puts params
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    end
  end

  private

    def user_params
      params.require(:user).permit(:phone, :account_sid, :auth_token)
    end

end
