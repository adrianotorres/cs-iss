# frozen_string_literal: true

# spec/models/inss_calculator_spec.rb
require "rails_helper"
require_relative "../../app/services/inss_calculator"

RSpec.describe InssCalculator, type: :model do
  describe "#calculate_discount" do
    # Here's how the calculation looks for a salary of $3,000.00 as an example, which falls into the 3rd income bracket:
    # ● 1st income bracket: $1,045.00 x 0.075 = $78.37
    # ● 2nd income bracket: [$2,089.60 - $1,045.00] = $1,044.60 x 0.09 = $94.01
    # ● Bracket reaching the salary: [$3,000.00 - $2,089.60] = $910.40 x 0.12 = $109.24
    # ● Total to be collected: $109.24 + $94.01 + $78.37 = $281.62
    it "calculates the total discount for a given salary using multiple strategies" do
      calculator = InssCalculator.new(3000.00)

      total_discount = calculator.calculate_discount

      expect(total_discount).to eq(281.62)
    end

    it "handles a salary above the last strategy range" do
      calculator = InssCalculator.new(7000.00)

      total_discount = calculator.calculate_discount

      expect(total_discount.round(2)).to eq(713.08)
    end
  end
end
