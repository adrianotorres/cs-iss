# frozen_string_literal: true

class DestroyProponent
  def initialize(id)
    @id = id
    @proponent_repository = ProponentRepository.new
  end

  def destroy
    status = @proponent_repository.destroy(@id) ? :success : :error

    {
      status:
    }
  end
end
