module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_playlist
    @current_playlist ||= session[:playlist_id]
  end

end
