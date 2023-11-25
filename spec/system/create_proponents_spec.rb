# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'CreateProponents', type: :system do
  let(:i18n_attributes) { 'activemodel.attributes.proponent_form' }
  let(:proponent_attr_blank_msg) { I18n.t('activemodel.errors.models.proponent_form.blank') }

  before do
    driven_by(:rack_test)
  end

  context 'navigation' do
    it 'should be able to navigate to create page from list' do
      visit proponents_path

      click_button I18n.t('proponent.buttons.link_to_create')

      expect(page).to have_content(I18n.t('proponent.headers.new'))
      expect(page).to have_selector('form#new_proponent_form')
    end
  end

  context 'creation' do
    let(:proponent) { build(:proponent, :with_address) }

    it 'should be able to create a new proponent' do
      visit new_proponent_path

      fill_in I18n.t("#{i18n_attributes}.name"), with: proponent.name
      fill_in I18n.t("#{i18n_attributes}.cpf"), with: proponent.cpf
      fill_in I18n.t("#{i18n_attributes}.salary"), with: proponent.salary
      fill_in I18n.t("#{i18n_attributes}.street"), with: proponent.address.street
      fill_in I18n.t("#{i18n_attributes}.number"), with: proponent.address.number
      fill_in I18n.t("#{i18n_attributes}.district"), with: proponent.address.district
      fill_in I18n.t("#{i18n_attributes}.city"), with: proponent.address.city
      fill_in I18n.t("#{i18n_attributes}.state"), with: proponent.address.state

      select '15', from: 'proponent_form_birthday_3i'
      select 'Março', from: 'proponent_form_birthday_2i'
      select '1990', from: 'proponent_form_birthday_1i'

      click_button I18n.t('proponent.buttons.create')

      expect(page).to have_content(I18n.t('proponent.messages.create_successfully'))
      expect(page).to have_content("#{I18n.t("#{i18n_attributes}.name")}: #{proponent.name}")
      expect(page).to have_content("#{I18n.t("#{i18n_attributes}.street")}: #{proponent.address.street}")
    end

    it 'should not be able to create a new proponent with an invalid cpf' do
      visit new_proponent_path

      fill_in I18n.t("#{i18n_attributes}.cpf"), with: '123456'

      click_button I18n.t('proponent.buttons.create')

      expect(page).to have_content("#{I18n.t("#{i18n_attributes}.cpf")} " \
        "#{I18n.t('activemodel.errors.models.proponent_form.attributes.cpf.invalid')}")
    end
  end

  context 'validation' do
    it 'should be able to validate required fields' do
      visit new_proponent_path

      click_button I18n.t('proponent.buttons.create')

      expect(page).to have_content("#{I18n.t("#{i18n_attributes}.name")} #{proponent_attr_blank_msg}")
      expect(page).to have_content("#{I18n.t("#{i18n_attributes}.cpf")} #{proponent_attr_blank_msg}")
      expect(page).to have_content("#{I18n.t("#{i18n_attributes}.salary")} #{proponent_attr_blank_msg}")
      expect(page).to have_content("#{I18n.t("#{i18n_attributes}.street")} #{proponent_attr_blank_msg}")
      expect(page).to have_content("#{I18n.t("#{i18n_attributes}.number")} #{proponent_attr_blank_msg}")
      expect(page).to have_content("#{I18n.t("#{i18n_attributes}.district")} #{proponent_attr_blank_msg}")
      expect(page).to have_content("#{I18n.t("#{i18n_attributes}.city")} #{proponent_attr_blank_msg}")
      expect(page).to have_content("#{I18n.t("#{i18n_attributes}.state")} #{proponent_attr_blank_msg}")
    end
  end
end
# rubocop:enable Metrics/BlockLength
