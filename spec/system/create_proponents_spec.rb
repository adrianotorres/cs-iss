# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'CreateProponents', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'should be able to navigate to create page from list' do
    visit proponents_path

    click_button I18n.t('proponent.buttons.link_to_create')

    expect(page).to have_content(I18n.t('proponent.headers.new'))
    expect(page).to have_selector('form#new_proponent_form')
  end

  it 'should be able to create a new proponent' do
    visit new_proponent_path

    fill_in I18n.t('activemodel.attributes.proponent_form.name'), with: 'John Doe'
    fill_in I18n.t('activemodel.attributes.proponent_form.cpf'), with: CPF.generate
    fill_in I18n.t('activemodel.attributes.proponent_form.salary'), with: 5000
    select '15', from: 'proponent_form_birthday_3i' # Dia
    select 'Março', from: 'proponent_form_birthday_2i' # Mês
    select '1990', from: 'proponent_form_birthday_1i' # Ano

    click_button I18n.t('proponent.buttons.create')

    expect(page).to have_content(I18n.t('proponent.messages.create_successfully'))
    expect(page).to have_content("#{I18n.t('activemodel.attributes.proponent_form.name')}: John Doe")
  end

  it 'should not be able to create a new proponent with name blank' do
    visit new_proponent_path

    fill_in I18n.t('activemodel.attributes.proponent_form.cpf'), with: '123.456.789-01'
    fill_in I18n.t('activemodel.attributes.proponent_form.salary'), with: 5000

    click_button I18n.t('proponent.buttons.create')

    expect(page).to have_content("#{I18n.t('activemodel.attributes.proponent_form.name')} " \
      "#{I18n.t('activemodel.errors.models.proponent_form.attributes.name.blank')}")
  end

  it 'should not be able to create a new proponent with cpf blank' do
    visit new_proponent_path

    fill_in I18n.t('activemodel.attributes.proponent_form.name'), with: 'John Doe'
    fill_in I18n.t('activemodel.attributes.proponent_form.salary'), with: 5000

    click_button I18n.t('proponent.buttons.create')

    expect(page).to have_content("#{I18n.t('activemodel.attributes.proponent_form.cpf')} " \
      "#{I18n.t('activemodel.errors.models.proponent_form.attributes.cpf.blank')}")
  end

  it 'should not be able to create a new proponent with an invalid cpf' do
    visit new_proponent_path

    fill_in I18n.t('activemodel.attributes.proponent_form.name'), with: 'John Doe'
    fill_in I18n.t('activemodel.attributes.proponent_form.salary'), with: 5000
    fill_in I18n.t('activemodel.attributes.proponent_form.cpf'), with: '123456'

    click_button I18n.t('proponent.buttons.create')

    expect(page).to have_content("#{I18n.t('activemodel.attributes.proponent_form.cpf')} " \
      "#{I18n.t('activemodel.errors.models.proponent_form.attributes.cpf.invalid')}")
  end

  it 'should not be able to create a new proponent with salary blank' do
    visit new_proponent_path

    fill_in I18n.t('activemodel.attributes.proponent_form.name'), with: 'John Doe'
    fill_in I18n.t('activemodel.attributes.proponent_form.cpf'), with: '123.456.789-01'

    click_button I18n.t('proponent.buttons.create')

    expect(page).to have_content("#{I18n.t('activemodel.attributes.proponent_form.salary')} " \
    "#{I18n.t('activemodel.errors.models.proponent_form.attributes.salary.blank')}")
  end
end
# rubocop:enable Metrics/BlockLength
