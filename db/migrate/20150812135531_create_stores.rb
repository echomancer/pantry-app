class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
    add_index :stores, :name, unique: true
    add_index :stores, :slug, unique: true
  end
end
