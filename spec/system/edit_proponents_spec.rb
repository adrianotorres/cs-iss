# frozen_string_literal: true

require "rails_helper"

RSpec.describe "EditProponents", type: :system do
  let(:user) { create(:user) }
  let(:proponent) { create(:proponent) }

  before do
    create(:address, proponent:)
    create(:personal_phone, proponent:)
    sign_in user
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  end

  context "navigation" do
    it "should be able to navigate to edit page from list and show its data" do
      visit proponents_path

      click_button t("proponents.index.table.buttons.edit")

      expect(page).to have_current_path(edit_proponent_path(proponent.id))
      expect(page).to have_content(t("proponents.edit.title"))
      expect(page).to have_selector("form[action='/proponents/#{proponent.id}']")
      expect(page).to have_field(form_label(:proponent_form, :name), with: proponent.name)
      expect(page).to have_field(form_label(:proponent_form, :street), with: proponent.address.street)
      expect(page).to have_field(form_label(:proponent_form, :street), with: proponent.address.street)
      # expect(page).to have_field(model_label(:phone, :number), with: proponent.phones.first.number)
    end
  end

  context "update" do
    let(:proponent) { build(:proponent, :with_address, :with_phones) }
    let(:address) { proponent.address }

    it "should be able to update a proponent and visualize the alteration" do
      visit edit_proponent_path(proponent.id)

      new_name = proponent.name.reverse
      fill_in form_label(:proponent_form, :name), with: new_name

      click_button t("proponents.edit.buttons.submit")

      expect(page).to have_content(t("proponents.messages.update_successfully"))
      expect(page).to have_content(new_name)
    end
  end

  context "validation" do
    it "should be able to validate required fields" do
      visit edit_proponent_path(proponent.id)

      fill_in form_label(:proponent_form, :name), with: ""

      click_button t("proponents.edit.buttons.submit")

      expect(page).to have_content("#{form_label(:proponent_form, :name)} #{t('errors.messages.blank')}")
    end
  end
end
