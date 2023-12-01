# frozen_string_literal: true

require "rails_helper"

RSpec.describe "DestroyProponents", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  end

  context "destroy" do
    it "should be able to destroy a proponent" do
      proponent = create(:proponent)
      visit proponents_path

      click_button t("proponents.index.table.buttons.destroy")

      alert = page.driver.browser.switch_to.alert
      alert.accept

      expect(page).to have_content(t("proponents.messages.destroy_successfully"))
      expect(page).to have_content(t("proponents.index.table.empty"))
      expect { ProponentRepository.new.find(proponent.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should not be able to destroy a proponent if user cancel the action" do
      proponent = create(:proponent)
      visit proponents_path

      click_button t("proponents.index.table.buttons.destroy")

      alert = page.driver.browser.switch_to.alert
      alert.dismiss

      proponent.reload

      expect(page).to have_content(proponent.name)
    end
  end
end
