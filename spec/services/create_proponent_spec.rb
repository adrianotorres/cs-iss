# frozen_string_literal: true

require "rails_helper"
require_relative "../../app/services/create_proponent"

RSpec.describe CreateProponent, type: :model do
  describe "#create" do
    let(:proponent_form) { build(:proponent_form) }

    it "should be able to create a new proponent" do
      create_proponent = CreateProponent.new(proponent_form)
      create_proponent_response = create_proponent.create

      expect(Proponent.last).to_not be_nil
      expect(create_proponent_response[:status]).to eq(:success)
      expect(CalculateProponentSalaryLiquidJob).to have_been_enqueued.with(create_proponent_response[:proponent].id)
    end

    it "should not be able to create a new proponent with a nil name" do
      proponent_form.name = nil
      create_proponent = CreateProponent.new(proponent_form)

      create_proponent_response = create_proponent.create

      expect(Proponent.last).to be_nil
      expect(create_proponent_response[:status]).to eq(:error)
      expect(proponent_form.errors[:name]).to include(t("errors.messages.blank"))
      expect(proponent_form.errors.size).to eq(1)
    end
  end
end
