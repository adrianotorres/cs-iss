# frozen_string_literal: true

class CalculateProponentSalaryLiquidJob < ApplicationJob
  queue_as :default

  def perform(proponent_id)
    proponent = Proponent.find(proponent_id)
    salary_liquid = proponent.salary.to_f - proponent.inss
    proponent.update(salary_liquid:)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
