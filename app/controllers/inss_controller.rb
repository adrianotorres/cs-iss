# frozen_string_literal: true

# Controller responsible for handling INSS (Brazilian Social Security) calculations.
# Manages interactions related to calculating INSS discounts based on user-provided salary.
# Uses the InssCalculator service to perform the actual discount calculations.
class InssController < ApplicationController
  def calculate
    salary = params[:salary].to_f
    inss_calculator = InssCalculator.new(salary)
    discount = inss_calculator.calculate_discount

    render json: {discount:}
  end
end
