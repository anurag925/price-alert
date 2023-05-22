# frozen_string_literal: true

# Migration to create alerts table
class CreateAlerts < ActiveRecord::Migration[7.0]
  def change
    create_table :alerts do |t|
      t.float :amount
      t.integer :status, limit: 1, default: 0
      t.belongs_to :user

      t.timestamps
    end
    add_index :alerts, %i[status amount]
  end
end
