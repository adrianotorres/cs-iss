# frozen_string_literal: true

require_relative '../../app/services/inss_strategy'

# rubocop:disable Metrics
RSpec.describe InssStrategy, type: :model do
  describe '#calculate_discount' do
    it 'should be able to calculate discount for the given salary within the strategy range' do
      strategy = InssStrategy.new(1000, 2000, 0.1)
      salary_within_range = 1500

      discount = strategy.calculate_discount(salary_within_range, 0)

      expect(discount).to eq(150)
    end

    it 'should return the correctly taxable value' do
      strategy = InssStrategy.new(1000, 2000, 0.1)
      salary_below_range = 2500

      strategy.calculate_discount(salary_below_range, 0)
      taxable_value = strategy.taxable_value

      expect(taxable_value).to eq(2000)
    end

    it 'should be able to calculates discount for the maximum salary within the strategy range' do
      strategy = InssStrategy.new(1000, 2000, 0.1)
      maximum_salary_within_range = 2000

      discount = strategy.calculate_discount(maximum_salary_within_range, 0)

      expect(discount).to eq(200)
    end

    it 'should be able to calculates discount for the maximum salary when above the strategy range' do
      strategy = InssStrategy.new(1000, 2000, 0.1)
      maximum_salary_above_range = 2200

      discount = strategy.calculate_discount(maximum_salary_above_range, 0)

      expect(discount).to eq(200)
    end
  end
end
# rubocop:enable Metrics
