# Ensure hdm configuration has proper defaults
Rails.application.config.after_initialize do
  # Ensure display_unused_environments has a default value of true
  Rails.configuration.hdm.display_unused_environments = true if Rails.configuration.hdm.display_unused_environments.nil?

  # Ensure exclude_environments is always an array
  Rails.configuration.hdm.exclude_environments ||= []

  # Convert to array if it's not already
  unless Rails.configuration.hdm.exclude_environments.is_a?(Array)
    # If it's a hash, extract the keys
    Rails.configuration.hdm.exclude_environments = if Rails.configuration.hdm.exclude_environments.is_a?(Hash)
                                                     Rails.configuration.hdm.exclude_environments.keys
                                                   else
                                                     # Otherwise, reset to empty array
                                                     []
                                                   end
  end
end
