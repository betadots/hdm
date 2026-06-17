# Ensure hdm configuration has proper defaults
Rails.application.config.after_initialize do
  # Ensure display_unused_environments has a default value of true
  if Rails.configuration.hdm.display_unused_environments.nil?
    Rails.configuration.hdm.display_unused_environments = true
  end
  
  # Ensure exclude_environments is always an array
  Rails.configuration.hdm.exclude_environments ||= []
  
  # Convert to array if it's not already
  unless Rails.configuration.hdm.exclude_environments.is_a?(Array)
    # If it's a hash, extract the keys
    if Rails.configuration.hdm.exclude_environments.is_a?(Hash)
      Rails.configuration.hdm.exclude_environments =
        Rails.configuration.hdm.exclude_environments.keys
    else
      # Otherwise, reset to empty array
      Rails.configuration.hdm.exclude_environments = []
    end
  end
end
