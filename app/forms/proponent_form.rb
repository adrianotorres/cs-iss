# frozen_string_literal: true

# ProponentForm is a form object that encapsulates the logic for handling
# and validating data related to the creation of a Proponent. It includes
# the ActiveModel::Model module to provide ActiveRecord-like features, such
# as validations.
#
# Methods:
# - `as_proponent`: Returns a hash with the form attributes suitable for creating a Proponent
class ProponentForm
  include ActiveModel::Model

  attr_accessor :name, :cpf, :birthday, :salary

  validates :name, :cpf, :salary, presence: true
  validate :valid_cpf

  def initialize(attrs = {})
    @birthday = Date.today.year - 18
    super(attrs)
  end

  def as_proponent
    { name:, cpf:, birthday:, salary: }
  end

  private

  def valid_cpf
    return if cpf.blank? || CPF.valid?(cpf)

    errors.add(:cpf, I18n.t('activemodel.errors.models.proponent_form.attributes.cpf.invalid'))
  end
end
