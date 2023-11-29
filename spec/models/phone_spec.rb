# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Phone, type: :model do
  describe 'relations' do
    it { should belong_to(:proponent) }
  end

  describe 'validations' do
    it { should validate_presence_of(:area_code) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:phone_type) }
  end
end
