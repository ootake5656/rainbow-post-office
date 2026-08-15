module ApplicationHelper
  def bottom_navigation_visible?
    return false unless logged_in?

    visible_pages = {
      "static_pages" => %w[top diary_coming_soon],
      "letters" => %w[index show],
      "replies" => %w[show],
      "mypages" => %w[show]
    }

    visible_pages.fetch(controller_path, []).include?(action_name)
  end

  def bottom_navigation_item_class(item)
    classes = [ "bottom-navigation__item" ]
    classes << "bottom-navigation__item--active" if bottom_navigation_active?(item)
    classes.join(" ")
  end

  def bottom_navigation_active?(item)
    case item
    when :home
      controller_path == "static_pages" && action_name == "top"
    when :diary
      controller_path == "static_pages" && action_name == "diary_coming_soon"
    when :letters
      controller_path.in?(%w[letters replies])
    when :mypage
      controller_path == "mypages"
    else
      false
    end
  end
end
