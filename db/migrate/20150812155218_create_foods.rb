class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.references :producer, index: true, foreign_key: true
      t.integer :upc
      t.decimal :servings
      t.decimal :serving_size
      t.integer :unit
      t.string :slug

      t.timestamps null: false
    end
    add_index :foods, :slug, unique: true
    add_index :foods, [:name, :producer_id, :upc], unique: true
  end
end
