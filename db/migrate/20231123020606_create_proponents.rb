# frozen_string_literal: true

# Mirgation to create proponents table
class CreateProponents < ActiveRecord::Migration[7.1]
  def change
    create_table :proponents, id: :uuid do |t|
      t.string :name, null: false
      t.jsonb :cpf, null: false
      t.jsonb :salary, null: false
      t.date :birthday

      t.timestamps
    end

    add_index :proponents, :cpf, unique: true
  end
end
