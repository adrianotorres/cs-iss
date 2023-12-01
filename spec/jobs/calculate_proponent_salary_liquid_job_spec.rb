# frozen_string_literal: true

require "rails_helper"

RSpec.describe CalculateProponentSalaryLiquidJob, type: :job do
  describe "#perform" do
    let(:proponent) { create(:proponent, salary:, inss: 281.62) }

    context "with salaray as float" do
      let(:salary) { 3000 }

      it "should be able to calculate the proponent salary liquid" do
        described_class.perform_now(proponent.id)
        expect(proponent.reload.salary_liquid).to eq(2718.38)
      end
    end

    context "with salaray as string" do
      let(:salary) { "3000" }

      it "should be able to calculate the proponent salary liquid" do
        described_class.perform_now(proponent.id)
        expect(proponent.reload.salary_liquid).to eq(2718.38)
      end
    end

    context "with nonexistent id" do
      it "should be able to calculate the proponent salary liquid" do
        response = described_class.perform_now(1)
        expect(response).to be_nil
      end
    end
  end
end
