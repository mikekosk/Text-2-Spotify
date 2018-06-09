class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def reply
    ## Parse Message
    message_body = params["Body"]
    from_number = params["From"]
    account_sid = params["AccountSid"]

    ## boot twilio
    user = User.find_by(account_sid: account_sid)
    account_sid = user.account_sid
    auth_token = user.auth_token
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    ## Pull up User Playlist
    hash = user.account_hash
    playlist_id = user.playlist_id
    puts playlist_id, hash
    spotify_user = RSpotify::User.new(hash)
    current_playlist = spotify_user.playlists[playlist_id]

    ## Add track to playlist
    tracks = RSpotify::Track.search(message_body, limit: 1)
    current_playlist.add_tracks!(tracks)
    track_name = tracks.first.name
    artist_name = tracks.first.artists.first.name

    @client.messages
      .create({
        from: '16304267198',
        to: from_number,
        body: "I added the song #{track_name} by #{artist_name}"
      })

    #redirect_to(:action => :show)
    # user_path(:id => 1, :playlist_id => 2, :action => 'show')
  end

end
