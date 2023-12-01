# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User Sessions", type: :system do
  before do
    # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  end

  context "login failed" do
    it "should not be able to log in with noexistent user" do
      visit new_user_session_path

      fill_in t("simple_form.labels.user.email"), with: "user@example.com"
      fill_in t("simple_form.labels.user.password"), with: "secret_password"

      click_button t("devise.sessions.new.buttons.login")

      expect(page).to have_content(t("devise.failure.not_found_in_database"))
    end

    it "should not be able to log in with user blank" do
      visit new_user_session_path

      click_button t("devise.sessions.new.buttons.login")

      expect(page).to have_content(t("devise.failure.invalid"))
    end
  end

  context "login successful" do
    let(:user) { create(:user) }

    it "should be able to log in with correct credentials" do
      visit new_user_session_path

      fill_in t("simple_form.labels.user.email"), with: user.email
      fill_in t("simple_form.labels.user.password"), with: user.password

      click_button t("devise.sessions.new.buttons.login")

      expect(page).to have_current_path(root_path)
      expect(page).to have_content(t("devise.successful.login"))
    end
  end
end
