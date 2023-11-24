# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponent, type: :model do
  describe 'validations' do
    subject { create(:proponent) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:salary) }
    it { should validate_presence_of(:cpf) }
    it { should validate_uniqueness_of(:cpf).case_insensitive }
  end

  describe 'scopes' do
    describe 'with_cpf' do
      let!(:proponent) { create(:proponent, cpf: '12345678900') }

      it 'should return proponent with the specified cpf' do
        result = Proponent.with_cpf('12345678900')
        expect(result).to include(proponent)
      end

      it 'should not return proponent with different cpf' do
        result = Proponent.with_cpf('98765432100')
        expect(result).not_to include(proponent)
      end
    end
  end
end
