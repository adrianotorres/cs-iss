# frozen_string_literal: true

# Proponent
#
# The `Proponent` model represents an poponent in the system.
# Proponents are individuals who provide information such as name,
# CPF (Brazilian social security number), birthday, and salary.
#
# Attributes:
# - `name`: The name of the proponent.
# - `cpf`: The CPF (unique) of the proponent.
# - `birthday`: The birthday of the proponent.
# - `salary`: The salary of the proponent.
# - `salary_liquid`: The salary liquid of the proponent.
# - `address`: The address(Address model) of the proponent.
#
# Usage Example:
# ```ruby
# proponent = Proponent.new(name: "John Doe", cpf: "123.456.789-09", birthday: Date.new(1980, 1, 1), salary: 5000.0)
# ```
#
# Validations:
# - `name`: Must be present.
# - `cpf`: Must be unique and present.
# - `birthday`: Must be a valid date.
# - `salary`: Can be a decimal number.
# - `salary liquid`: Can be a decimal number.
#
class Proponent < ApplicationRecord
  has_one :address, dependent: :destroy
  has_many :phones, dependent: :destroy

  encrypts :cpf, deterministic: true
  encrypts :salary, deterministic: true
  encrypts :salary_liquid, deterministic: true

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :salary, presence: true

  accepts_nested_attributes_for :phones

  scope :by_cpf, ->(cpf) { where cpf: }
end
