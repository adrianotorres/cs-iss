# frozen_string_literal: true

class CreateProponent
  def initialize(proponent_form)
    @proponent_form = proponent_form
    @proponent_repository = ProponentRepository.new
  end

  def create
    status = :error
    proponent = nil

    if @proponent_form.valid?
      proponent = @proponent_repository.create(@proponent_form.as_proponent)

      if proponent.valid?
        CalculateProponentSalaryLiquidJob.perform_later(proponent.id)
        status = :success
      else
        @proponent_form.errors.merge!(proponent.errors)
      end
    end

    {
      status:,
      proponent:
    }
  end
end
