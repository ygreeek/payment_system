# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :email, null: false
      t.string :phone
      t.decimal :total_amount, precision: 10, scale: 2
      t.timestamps
    end

    add_index :customers, :email, unique: true
  end
end
