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

  attr_accessor :name, :cpf, :birthday, :salary, :street, :number, :district, :city, :state, :zip_code, :phones, :inss

  validates :name, :cpf, :salary, :street, :number, :district, :city, :state, presence: true
  validate :valid_cpf
  validate :valid_phones

  def initialize(attrs = {})
    @birthday = Date.today.year - 18
    super(attrs)
  end

  def as_proponent
    {
      name:,
      cpf:,
      birthday:,
      salary:,
      inss: inss.sub(',', '.').to_f,
      phones: build_phones,
      address: build_address
    }
  end

  private

  def valid_cpf
    return if cpf.blank? || CPF.valid?(cpf)

    errors.add(:cpf, I18n.t('activemodel.errors.models.proponent_form.attributes.cpf.invalid'))
  end

  def valid_phones
    return if phones.all? { |_k, v| v.present? }

    errors.add(:phones, I18n.t('activemodel.errors.models.proponent_form.attributes.phones.blank'))
  end

  def build_address
    Address.new(
      street:,
      number:,
      district:,
      city:,
      state:,
      zip_code:
    )
  end

  def build_phones
    # phones.map { |_k, v| Phone.new(v) }
    [Phone.new(phones)]
  end
end
