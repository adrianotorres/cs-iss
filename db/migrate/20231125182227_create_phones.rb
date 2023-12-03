# frozen_string_literal: true

# Mirgation to create phones table
class CreatePhones < ActiveRecord::Migration[7.1]
  def change
    create_table :phones, id: :uuid do |t|
      t.references :proponent, type: :uuid, null: false, foreign_key: true
      t.string :area_code
      t.string :number
      t.integer :phone_type, default: 0

      t.timestamps
    end
  end
end
