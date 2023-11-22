# frozen_string_literal: true

module CsIss
  Config = SuperConfig.new do
    mandatory :database_url, string
  end
end
