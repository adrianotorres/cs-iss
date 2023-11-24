# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
10.times do |n|
  cpf = n.to_s.rjust(11, n.to_s).gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4')

  next if Proponent.with_cpf(cpf).exists?

  Proponent.create(
    name: "John Smith - #{n}",
    salary: rand(90_000..850_000) / 100.0,
    cpf:
  )
end
