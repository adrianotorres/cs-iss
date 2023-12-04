# frozen_string_literal: true

# Mirgation to create addresses table
class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses, id: :uuid do |t|
      t.string :street
      t.string :number
      t.string :district
      t.string :city
      t.string :state
      t.string :zip_code
      t.references :proponent, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
