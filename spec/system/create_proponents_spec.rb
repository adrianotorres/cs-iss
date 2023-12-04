# frozen_string_literal: true

require "rails_helper"

RSpec.describe "CreateProponents", type: :system do
  before { sign_in create(:user) }

  context "navigation" do
    it "should be able to navigate to create page from list" do
      visit proponents_path

      click_button t("proponents.index.buttons.create")

      expect(page).to have_content(t("proponents.new.title"))
      expect(page).to have_selector("form#new_proponent_form")
    end
  end

  context "creation" do
    let(:proponent) { build(:proponent, :with_address, :with_phones) }
    let(:address) { proponent.address }
    let(:personal_phone) { proponent.phones.find(&:personal?) }
    let(:reference_phone) { proponent.phones.find(&:reference?) }
    let(:proponent_presenter) do
      build(:proponent_presenter, proponent: Proponent.last)
    end

    it "should be able to create a new proponent and visualize its data" do
      visit new_proponent_path

      # Filling the poponent's data
      fill_in form_label(:proponent_form, :name), with: proponent.name
      fill_in form_label(:proponent_form, :cpf), with: proponent.cpf
      fill_in form_label(:proponent_form, :salary), with: proponent.salary

      # Filling the poponent's address data
      fill_in form_label(:proponent_form, :street), with: address.street
      fill_in "proponent_form_number", with: address.number
      fill_in form_label(:proponent_form, :district), with: address.district
      fill_in form_label(:proponent_form, :city), with: address.city
      fill_in form_label(:proponent_form, :state), with: address.state

      # Filling the poponent's personal phone
      fill_in "proponent_form_personal_area_code", with: personal_phone.area_code
      fill_in "proponent_form_personal_number", with: personal_phone.number
      select model_label(:phone, "phone_types.personal"), from: "proponent_form_personal_phone_type"

      # Filling the poponent's reference phone
      fill_in "proponent_form_reference_area_code", with: reference_phone.area_code
      fill_in "proponent_form_reference_number", with: reference_phone.number
      select model_label(:phone, "phone_types.reference"), from: "proponent_form_reference_phone_type"

      click_button t("proponents.new.buttons.submit")

      expect(page).to have_content(t("proponents.messages.create_successfully"))
      expect(page).to have_content("#{form_label(:proponent_form, :name)}: " \
                                   "#{proponent_presenter.name}")
      expect(page).to have_content("#{form_label(:proponent_form, :cpf)}: " \
                                   "#{proponent_presenter.cpf}")
      expect(page).to have_content("#{form_label(:proponent_form, :salary)}: " \
                                   "#{proponent_presenter.salary}")
      expect(page).to have_content("#{form_label(:proponent_form, :inss)}: " \
                                   "#{proponent_presenter.inss}")
      expect(page).to have_content("#{form_label(:proponent_form, :street)}: " \
                                   "#{proponent_presenter.street}")
      expect(page).to have_content("#{model_label(:phone, :number)}: #{personal_phone.number}")
      expect(page).to have_content("#{model_label(:phone, :number)}: #{reference_phone.number}")
    end

    it "should not be able to create a new proponent with an invalid cpf" do
      visit new_proponent_path

      fill_in form_label(:proponent_form, :cpf), with: "123456"

      click_button t("proponents.new.buttons.submit")

      expect(page).to have_content("#{form_label(:proponent_form, :cpf)} " \
                                   "#{form_error(:proponent_form, 'attributes.cpf.invalid')}")
    end
  end

  context "validation" do
    it "should be able to validate required fields" do
      visit new_proponent_path

      click_button t("proponents.new.buttons.submit")

      expect(page).to have_content("#{form_label(:proponent_form, :name)} #{t('errors.messages.blank')}")
      expect(page).to have_content("#{form_label(:proponent_form, :cpf)} #{t('errors.messages.blank')}")
      expect(page).to have_content("#{form_label(:proponent_form, :salary)} #{t('errors.messages.blank')}")
      expect(page).to have_content("#{form_label(:proponent_form, :street)} #{t('errors.messages.blank')}")
      expect(page).to have_content("#{form_label(:proponent_form, :number)} #{t('errors.messages.blank')}")
      expect(page).to have_content("#{form_label(:proponent_form, :district)} #{t('errors.messages.blank')}")
      expect(page).to have_content("#{form_label(:proponent_form, :city)} #{t('errors.messages.blank')}")
      expect(page).to have_content("#{form_label(:proponent_form, :state)} #{t('errors.messages.blank')}")
      expect(page).to have_content(t("activemodel.errors.models.proponent_form.attributes.phones.blank"))
    end
  end
end
