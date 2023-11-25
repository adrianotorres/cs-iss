# frozen_string_literal: true

# ProponentPresenter is a presenter class that encapsulates the presentation logic
# for a Proponent object. It provides methods to access various attributes of a
# Proponent, including name, cpf, birthday, salary, and address details such as
# street, number, district, city, state, and zip code.
class ProponentPresenter
  def initialize(proponent)
    @proponent = proponent
  end

  def name
    @proponent.name
  end

  def cpf
    @proponent.cpf
  end

  def birthday
    @proponent.birthday
  end

  def salary
    @proponent.salary
  end

  def street
    @proponent.address&.street
  end

  def number
    @proponent.address&.number
  end

  def district
    @proponent.address&.district
  end

  def city
    @proponent.address&.city
  end

  def state
    @proponent.address&.state
  end

  def zip_code
    @proponent.address&.zip_code
  end
end
