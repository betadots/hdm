module ApplicationHelper
  FLASH_CLASSES = {
    "notice" => "alert-success",
    "error" => "alert-danger",
    "alert" => "alert-warning"
  }.freeze
  ROLE_BADGE_COLORS = {
    "admin" => "bg-danger",
    "regular" => "bg-success",
    "api" => "bg-info"
  }.freeze

  def flash_class(level)
    FLASH_CLASSES[level]
  end

  def format_path(file, key)
    tag_name, classes =
      if file.has_key?(key) # rubocop:disable Style/PreferredHashMethods
        [:b, "text-primary"]
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

  def role_badge_color(role)
    ROLE_BADGE_COLORS[role]
  end
end
