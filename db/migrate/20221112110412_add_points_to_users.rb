# frozen_string_literal: true

class AddPointsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :points, :integer, null: false, default: 0
  end
end
