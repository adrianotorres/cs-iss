# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    super do
      flash[:notice] = t("devise.successful.login")
    end
  end
end
