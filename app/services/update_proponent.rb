# frozen_string_literal: true

class UpdateProponent
  def initialize(proponent_form)
    @proponent_form = proponent_form
    @proponent_repository = ProponentRepository.new
  end

  def update
    status = :error

    status = :success if @proponent_form.valid? && @proponent_repository.update(@proponent_form.as_proponent)

    {
      status:
    }
  end
end
