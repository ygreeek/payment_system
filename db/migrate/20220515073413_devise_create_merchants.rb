# frozen_string_literal: true

class DeviseCreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string  :name, null: false
      t.text    :description, null: false, default: ''
      t.string  :email, null: false
      t.string  :status, null: false
      t.string  :encrypted_password, null: false, default: ''
      t.string  :reset_password_token
      t.datetime :reset_password_sent_at
      t.timestamps null: false
    end

    add_index :merchants, :email,                unique: true
    add_index :merchants, :reset_password_token, unique: true
  end
end
