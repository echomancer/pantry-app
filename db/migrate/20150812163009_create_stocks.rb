class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :store, index: true, foreign_key: true
      t.references :food, index: true, foreign_key: true
      t.decimal :price
      t.decimal :quantity
      t.decimal :discount
      t.datetime :bought
      t.references :user, index: true, foreign_key: true
      t.string :slug
      t.decimal :remaining

      t.timestamps null: false
    end
    add_index :stocks, :slug, unique: true
  end
end
