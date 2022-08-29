module ApplicationHelper
  def flash_class(level)
    case level
      when 'notice' then "alert alert-success"
      when 'error' then "alert alert-danger"
      when 'alert' then "alert alert-warning"
    end
  end

  def format_path(file, key)
    tag_name, classes =
      if file.has_key?(key)
        [:b, nil]
      elsif file.exist?
        [:span, "text-dark"]
      else
        [:em, "text-muted"]
      end
    tag.send(tag_name, file.path, class: classes)
  end

  def icon(name)
    bootstrap_icon(name)
  end

  def user_deletion_confirmation(user)
    if user == current_user
      'THIS IS YOUR ACCOUNT! Are you sure?'
    else
      'Are you sure?'
    end
  end
end
