# frozen_string_literal: true

module CsIss
  Config = SuperConfig.new do
    mandatory :database_url, string
    mandatory :locale, string
    optional :redis_url, string
  end
end
