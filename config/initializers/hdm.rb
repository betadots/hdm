Rails.application.config.after_initialize do
  hdm_config = Rails.configuration.hdm
  hdm_config.display_unused_environments = true if hdm_config.display_unused_environments.nil?
  hdm_config.exclude_environments ||= []

  next if hdm_config.exclude_environments.is_a?(Array)

  raise Hdm::Error, "exclude_environments must be an array"
end
