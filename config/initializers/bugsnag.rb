# frozen_string_literal: true

require 'bugsnag'

# To enable bugsnag just send BUGSNAG_API_KEY at you environment
Bugsnag.configure do |config|
  config.api_key = ENV['BUGSNAG_API_KEY']
  config.project_root = APP_ROOT
  # Because on kubernetes pod's we run at production mode
  # for find difference between  `staging` & `production`
  # use POD_NAMESPACE
  config.notify_release_stages = %w[production staging]
  config.release_stage = ENV['POD_NAMESPACE'] || APP_ENV
end
