# frozen_string_literal: true

# Class representing an INSS (Brazilian Social Security) calculation strategy for a specific
# income bracket. Each strategy includes the minimum and maximum salary range for the bracket
# and the corresponding tax rate.
class InssStrategy
  attr_reader :min_salary, :max_salary, :rate, :taxable_value

  def initialize(min_salary, max_salary, rate)
    @min_salary = min_salary
    @max_salary = max_salary
    @rate = rate
  end

  def calculate_discount(salary, already_taxable)
    @taxable_value = [salary, @max_salary].min - already_taxable
    (taxable_value * @rate).truncate(2)
  end
end
