# frozen_string_literal: true

# Mirgation to add inss field to proponents table
class AddInssToProponents < ActiveRecord::Migration[7.1]
  def change
    add_column :proponents, :inss, :float
  end
end
