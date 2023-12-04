# frozen_string_literal: true

class AddSalaryLiquidToProponents < ActiveRecord::Migration[7.1]
  def change
    add_column :proponents, :salary_liquid, :jsonb
  end
end
