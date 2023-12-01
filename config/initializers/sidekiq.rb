# frozen_string_literal: true

require "sidekiq"

Sidekiq.configure_client do |config|
  config.redis = {url: CsIss::Config.redis_url || "redis://localhost:6379/0"}
end

Sidekiq.configure_server do |config|
  config.redis = {url: CsIss::Config.redis_url || "redis://localhost:6379/0"}
end

Rails.application.config.active_job.queue_adapter = :sidekiq
