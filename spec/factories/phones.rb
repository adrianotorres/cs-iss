# frozen_string_literal: true

FactoryBot.define do
  factory :phone do
    area_code { Faker::PhoneNumber.area_code || Faker::Number.number(digits: 3) }
    number { Faker::PhoneNumber.cell_phone }
    proponent
  end

  factory :personal_phone, parent: :phone do
    phone_type { :personal }
  end

  factory :reference_phone, parent: :phone do
    phone_type { :reference }
  end
end
