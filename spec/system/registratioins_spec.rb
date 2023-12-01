# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Registrations", type: :system do
  before do
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  end

  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  context "signup failed" do
    it "should not be able to sign up with empty fields" do
      visit new_user_registration_path

      click_button t("devise.registrations.new.buttons.submit")

      expect(page).to have_content("Email #{t('errors.messages.blank')}")
      expect(page).to have_content("Password #{t('errors.messages.blank')}")
    end

    it "should not be able to sign up with password and password confirmation differents" do
      visit new_user_registration_path

      fill_in t("simple_form.labels.user.email"), with: email
      fill_in t("simple_form.labels.user.password"), with: password
      fill_in t("simple_form.labels.user.password_confirmation"), with: password.reverse

      click_button t("devise.registrations.new.buttons.submit")

      expect(page).to have_content("Password confirmation #{t('errors.messages.confirmation')}")
    end
  end

  context "signup successful" do
    it "should be able to sign up with correct fields" do
      visit new_user_registration_path

      fill_in t("simple_form.labels.user.email"), with: email
      fill_in t("simple_form.labels.user.password"), with: password
      fill_in t("simple_form.labels.user.password_confirmation"), with: password

      click_button t("devise.registrations.new.buttons.submit")

      expect(page).to have_text(t("devise.registrations.user.signed_up"))
    end
  end
end
