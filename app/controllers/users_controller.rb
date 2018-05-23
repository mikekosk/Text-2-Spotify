class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    spotify_user = RSpotify::User.new(session[:hash])
    if params[:playlist_id]
      playlist_id = params[:playlist_id].to_i
      @tracks = spotify_user.playlists[playlist_id].tracks(limit: 40)
    else
      @tracks = nil
    end

    if params[:sort_by] == 'name'
      @tracks = @tracks.sort_by(&:name)
    elsif params[:sort_by] == 'danceability'
      @tracks = @tracks.sort_by{|a| a.audio_features.danceability}
    else
      @tracks
    end

    if params[:save] == true
      spotify_user. 

  end

  def save
    spotify_user
  end

end
