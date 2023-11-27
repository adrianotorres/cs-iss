# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'CreateProponents', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'navigation' do
    it 'should be able to navigate to create page from list' do
      visit proponents_path

      click_button t('proponents.index.buttons.create')

      expect(page).to have_content(t('proponents.new.title'))
      expect(page).to have_selector('form#new_proponent_form')
    end
  end

  context 'creation' do
    let(:proponent) { build(:proponent, :with_address, :with_phones) }
    let(:address) { proponent.address }
    let(:personal_phone) { proponent.phones.find(&:personal?) }
    let(:reference_phone) { proponent.phones.find(&:reference?) }

    it 'should be able to create a new proponent' do
      visit new_proponent_path

      # Filling the poponent's data
      fill_in form_label(:proponent_form, :name), with: proponent.name
      fill_in form_label(:proponent_form, :cpf), with: proponent.cpf
      fill_in form_label(:proponent_form, :salary), with: proponent.salary
      select '15', from: 'proponent_form_birthday_3i'
      select 'Março', from: 'proponent_form_birthday_2i'
      select '1990', from: 'proponent_form_birthday_1i'

      # Filling the poponent's address data
      fill_in form_label(:proponent_form, :street), with: address.street
      fill_in form_label(:proponent_form, :number), with: address.number
      fill_in form_label(:proponent_form, :district), with: address.district
      fill_in form_label(:proponent_form, :city), with: address.city
      fill_in form_label(:proponent_form, :state), with: address.state

      # Filling the poponent's personal phone
      fill_in model_label(:phone, :area_code), with: personal_phone.area_code
      fill_in model_label(:phone, :number), with: personal_phone.number
      select model_label(:phone, 'phone_types.personal'), from: 'proponent_form_phones_phone_type'

      # Filling the poponent's reference phone
      fill_in model_label(:phone, :area_code), with: reference_phone.area_code
      fill_in model_label(:phone, :number), with: reference_phone.number
      select model_label(:phone, 'phone_types.reference'), from: 'proponent_form_phones_phone_type'

      click_button t('proponents.new.buttons.create')

      expect(page).to have_content(t('proponents.messages.create_successfully'))
      expect(page).to have_content("#{form_label(:proponent_form, :name)}: #{proponent.name}")
      expect(page).to have_content("#{form_label(:proponent_form, :street)}: #{address.street}")
      # expect(page).to have_content("#{model_label(:phone, :number)}: #{personal_phone.number}")
      expect(page).to have_content("#{model_label(:phone, :number)}: #{reference_phone.number}")
    end

    it 'should not be able to create a new proponent with an invalid cpf' do
      visit new_proponent_path

      fill_in form_label(:proponent_form, :cpf), with: '123456'

      click_button t('proponents.new.buttons.create')

      expect(page).to have_content("#{form_label(:proponent_form, :cpf)} " \
        "#{form_error(:proponent_form, 'attributes.cpf.invalid')}")
    end
  end

  context 'validation' do
    it 'should be able to validate required fields' do
      visit new_proponent_path

      click_button t('proponents.new.buttons.create')

      expect(page).to have_content("#{form_label(:proponent_form, :name)} #{form_error(:proponent_form, :blank)}")
      expect(page).to have_content("#{form_label(:proponent_form, :cpf)} #{form_error(:proponent_form, :blank)}")
      expect(page).to have_content("#{form_label(:proponent_form, :salary)} #{form_error(:proponent_form, :blank)}")
      expect(page).to have_content("#{form_label(:proponent_form, :street)} #{form_error(:proponent_form, :blank)}")
      expect(page).to have_content("#{form_label(:proponent_form, :number)} #{form_error(:proponent_form, :blank)}")
      expect(page).to have_content("#{form_label(:proponent_form, :district)} #{form_error(:proponent_form, :blank)}")
      expect(page).to have_content("#{form_label(:proponent_form, :city)} #{form_error(:proponent_form, :blank)}")
      expect(page).to have_content("#{form_label(:proponent_form, :state)} #{form_error(:proponent_form, :blank)}")
    end
  end
end
# rubocop:enable Metrics/BlockLength
