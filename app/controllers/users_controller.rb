class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    spotify_user = RSpotify::User.new(session[:hash])

    ## Select Playlist
    if params[:playlist_id]
      playlist_id = params[:playlist_id].to_i - 1
      @tracks = spotify_user.playlists[playlist_id].tracks(limit: 40)
    else
      @tracks = nil
    end

    ## Sort Playlist
    if params[:sort_by] == 'name'
      @tracks = @tracks.sort_by(&:name)
    elsif params[:sort_by] == 'danceability'
      @tracks = @tracks.sort_by{|a| a.audio_features.danceability}
    elsif params[:sort_by] == 'tempo'
      @tracks = @tracks.sort_by{|a| a.audio_features.tempo}
    elsif params[:sort_by] == 'valence'
      @tracks = @tracks.sort_by{|a| a.audio_features.valence}
    elsif params[:sort_by] == 'speechiness'
      @tracks = @tracks.sort_by{|a| a.audio_features.speechiness}
    elsif params[:sort_by] == 'instrumentalness'
      @tracks = @tracks.sort_by{|a| a.audio_features.instrumentalness}
    elsif params[:sort_by] == 'acousticness'
      @tracks = @tracks.sort_by{|a| a.audio_features.acousticness}
    elsif params[:sort_by] == 'energy'
      @tracks = @tracks.sort_by{|a| a.audio_features.energy}
    else
      @tracks
    end

    ## Save Playlist
    if params[:save] == 'true'
      ## Pull playlist name & sort style
      playlist_name = spotify_user.playlists[playlist_id].name
      sort_style = params[:sort_by]

      ## Create Playlist & Add Tracks
      new_playlist = spotify_user.create_playlist!("#{playlist_name},
        sorted by #{sort_style}")
      new_playlist.add_tracks!(@tracks)

      ## Redirect if successful
      flash[:success] = "Save Successful"
      redirect_to params.permit(:playlist_id, :sort_by)
        .merge({:playlist_id => 1})
    end


  end

  def save
    spotify_user
  end

end
