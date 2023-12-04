# frozen_string_literal: true

module CsIss
  Config = SuperConfig.new do
    mandatory :database_url, string
    optional :locale, string, "pt-BR"
    optional :redis_url, string
  end
end
