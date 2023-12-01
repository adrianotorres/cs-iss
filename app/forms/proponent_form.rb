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

  attr_accessor :name, :cpf, :birthday, :salary, :street, :number, :district,
                :city, :state, :zip_code, :phones, :inss, :id

  validates :name, :cpf, :salary, :street, :number, :district, :city, :state,
            presence: true
  validate :valid_cpf
  # validate :valid_phones

  def initialize(attrs = {})
    @birthday = Time.zone.today.year - 18 unless attrs[:birthday]
    super(attrs)
  end

  def as_proponent
    {
      id:,
      name:,
      cpf:,
      birthday:,
      salary:,
      inss: inss ? inss.to_s.sub(",", ".").to_f : 0,
      # phones: build_phones,
      address: build_address
    }
  end

  def self.from(proponent)
    new({
          id: proponent.id,
          name: proponent.name,
          cpf: proponent.cpf,
          birthday: proponent.birthday,
          salary: proponent.salary,
          inss: proponent.inss.to_s.sub(".", ","),
          phones: [proponent.phones.map(&:attributes)],
          street: proponent.address&.street,
          number: proponent.address&.number,
          district: proponent.address&.district,
          city: proponent.address&.city,
          state: proponent.address&.state,
          zip_code: proponent.address&.zip_code
        })
  end

  private def valid_cpf
    return if cpf.blank? || CPF.valid?(cpf)

    errors.add(:cpf,
               I18n.t("activemodel.errors.models.proponent_form.attributes.cpf.invalid"))
  end

  private def valid_phones
    return if phones.all? {|_k, v| v.present? }

    errors.add(:phones,
               I18n.t("activemodel.errors.models.proponent_form.attributes.phones.blank"))
  end

  private def build_address
    Address.new(
      street:,
      number:,
      district:,
      city:,
      state:,
      zip_code:
    )
  end

  private def build_phones
    # phones.map { |_k, v| Phone.new(v) }
    [Phone.new(phones)]
  end
end
