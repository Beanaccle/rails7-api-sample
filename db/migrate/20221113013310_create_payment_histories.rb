class CreatePaymentHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_histories do |t|
      t.references :product, foreign_key: true
      t.references :seller, null: false, foreign_key: { to_table: :users }
      t.references :buyer, null: false, foreign_key: { to_table: :users }
      t.string :product_name, null: false
      t.integer :product_price, null: false

      t.timestamps
    end
  end
end
