# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ListProponents', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'should be able to visualize the list of created proponents' do
    create_list(:proponent, 3)

    visit proponents_path

    expect(page).to have_selector('.record', count: 3)
  end

  context 'pagination' do
    it 'should be able to paginate the list' do
      create_list(:proponent, 8)

      visit proponents_path

      expect(page).to have_selector('.record', count: 5)
    end

    it 'should be able to go to the next page' do
      create_list(:proponent, 8)

      visit proponents_path
      click_link('Next ›')

      expect(page).to have_selector('.record', count: 3)
    end
  end
end
