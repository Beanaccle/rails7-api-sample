# frozen_string_literal: true

class AddUserToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :user, null: false, default: 0, foreign_key: true
  end
end
