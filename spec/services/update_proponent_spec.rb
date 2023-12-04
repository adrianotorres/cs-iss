# frozen_string_literal: true

require "rails_helper"
require_relative "../../app/services/update_proponent"

RSpec.describe UpdateProponent, type: :model do
  describe "#update" do
    let(:proponent_form) { build(:proponent_form) }

    it "should be able to update a new proponent" do
      proponent = ProponentRepository.new.create(proponent_form.as_proponent)
      proponent_form = ProponentForm.from(proponent)
      proponent_form.name = proponent_form.name.reverse

      update_proponent = described_class.new(proponent_form)
      update_proponent_response = update_proponent.update

      expect(proponent.reload.name).to eq(proponent_form.name)
      expect(update_proponent_response[:status]).to eq(:success)
    end

    it "should not be able to update a proponent with a nil name" do
      proponent = ProponentRepository.new.create(proponent_form.as_proponent)
      proponent_form = ProponentForm.from(proponent)
      proponent_form.name = nil

      update_proponent = described_class.new(proponent_form)
      update_proponent_response = update_proponent.update

      expect(update_proponent_response[:status]).to eq(:error)
      expect(proponent_form.errors[:name]).to include(t("errors.messages.blank"))
      expect(proponent_form.errors.size).to eq(1)
    end
  end
end
