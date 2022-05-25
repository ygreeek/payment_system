# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :transactions, id: :uuid do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.string  :status, null: false
      t.string  :customer_email, null: false
      t.string  :customer_phone
      t.string  :type
      t.references :merchant
      t.references :parent, type: :uuid
      t.timestamps
    end

    add_index :transactions, :type
    add_index :transactions, %i[type status]
  end
end
