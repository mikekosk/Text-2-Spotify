class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def reply
    boot_twilio

    ## Parse Message
    message_body = params["Body"]
    from_number = params["From"]
    account_sid = params["AccountSid"]
    account_sid = nil

    ## Pull up User Playlist
    user = User.find_by(account_sid: account_sid)
    hash = user.account_hash
    spotify_user = RSpotify::User.new(hash)
    current_playlist = spotify_user.playlists[1]

    ## Add track to playlist
    tracks = RSpotify::Track.search(message_body, limit: 1)
    # puts tracks
    # # puts '-----'
    # puts tracks.first.name
    # track_name = tracks.first.name

    current_playlist.add_tracks!(tracks)
    track_name = tracks.first.name

    @client.messages
      .create({
        from: '16304267198',
        to: from_number,
        body: "I added the song #{track_name}."
      })

    #redirect_to(:action => :show)
    # user_path(:id => 1, :playlist_id => 2, :action => 'show')
  end

  private

    def boot_twilio
      account_sid = 'ACd3f3ddb0a84556b722a94afaf6896a29'
      auth_token = 'de87d697b3813672be3ce7ae9fc3a989'
      @client = Twilio::REST::Client.new(account_sid, auth_token)
    end

end
