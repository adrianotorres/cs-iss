# frozen_string_literal: true

# Class responsible for calculating INSS (Brazilian Social Security) discounts based on
# various income brackets and corresponding tax rates.
class InssCalculator
  def initialize(salary)
    @salary = salary
  end

  def calculate_discount
    inss_strategies.reduce(
      {already_taxable: 0, total_discount: 0}
    ) do |values, strategy|
      total_discount = strategy.calculate_discount(@salary,
                                                   values[:already_taxable])
      break {total_discount: values[:total_discount]} unless total_discount.positive?

      {
        already_taxable: values[:already_taxable] += strategy.taxable_value,
        total_discount: values[:total_discount] + total_discount
      }
    end[:total_discount]
  end

  private def inss_strategies
    [
      InssStrategy.new(0, 1045.00, 0.075),
      InssStrategy.new(1045.00, 2089.60, 0.09),
      InssStrategy.new(2089.61, 3134.40, 0.12),
      InssStrategy.new(3134.41, 6101.06, 0.14)
    ]
  end
end
