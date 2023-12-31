# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

10.times do |n|
  cpf = n.to_s.rjust(11, n.to_s).gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4')

  next if Proponent.by_cpf(cpf).exists?

  salary = rand(90_000..850_000) / 100.0
  proponent = Proponent.create(
    name: "João da Silva - #{n}",
    salary:,
    inss: InssCalculator.new(salary).calculate_discount,
    birthday: Time.zone.today - rand((18 * 365)..(90 * 365)),
    cpf:,
    address: Address.new(
      street: "Franciso Sá",
      number: (n.positive? ? n * 100 : 100) + n,
      district: "Bairro Wellery",
      city: "Fortaleza",
      state: "Ceará",
      zip_code: "61500-000"
    ),
    phones: [
      Phone.new(
        area_code: "8#{n}",
        number: "#{''.rjust(5, '9')}-#{n.to_s.rjust(4, '9')}",
        phone_type: :personal
      ),
      Phone.new(
        area_code: "8#{n}",
        number: "#{''.rjust(5, '9')}-#{(n + 1).to_s.rjust(4, '9')}",
        phone_type: :reference
      )
    ]
  )
  CalculateProponentSalaryLiquidJob.perform_now(proponent.id)
end

user = User.where(email: "csiss@mail.com").first
User.new(email: "csiss@mail.com", password: "admincsiss").save unless user
