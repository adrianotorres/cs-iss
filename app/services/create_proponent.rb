# frozen_string_literal: true

class CreateProponent
  def initialize(proponent_form)
    @proponent_form = proponent_form
  end

  def create
    proponent = Proponent.create(@proponent_form.as_proponent)
    status = :success
    unless proponent.save
      @proponent_form.errors.merge!(proponent.errors)
      status = :error
    end

    CalculateProponentSalaryLiquidJob.perform_later(proponent.id)

    {
      status:,
      proponent:
    }
  end
end
