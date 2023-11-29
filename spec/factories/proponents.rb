# frozen_string_literal: true

FactoryBot.define do
  factory :proponent do
    name { Faker::Name.name }
    cpf { CPF.generate }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    salary { rand(90_000..850_000) / 100.0 }

    trait :with_address do
      address
    end

    trait :with_phones do
      phones { [build(:personal_phone), build(:reference_phone)] }
    end
  end

  factory :proponent_presenter do
    association :proponent

    initialize_with { new(proponent) }
  end
end
