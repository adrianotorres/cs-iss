# frozen_string_literal: true

require "rails_helper"

RSpec.describe Proponent, type: :model do
  describe "relations" do
    it { should have_one(:address) }
    it { should have_many(:phones) }
  end

  describe "validations" do
    subject { create(:proponent) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:salary) }
    it { should validate_presence_of(:cpf) }
    it { should validate_uniqueness_of(:cpf).case_insensitive }
  end

  describe "scopes" do
    describe "by_cpf" do
      let!(:proponent) { create(:proponent, cpf: "12345678900") }

      it "should return proponent with the specified cpf" do
        result = Proponent.by_cpf("12345678900")
        expect(result).to include(proponent)
      end

      it "should not return proponent with different cpf" do
        result = Proponent.by_cpf("98765432100")
        expect(result).not_to include(proponent)
      end
    end
  end
end
