module UsersHelper
  def sort_link(column, title = nil)
    title ||= column.titleize

    link_to "#{title} <span class='#{icon}'></span>".html_safe, {column: column, direction: direction}
  end
end
