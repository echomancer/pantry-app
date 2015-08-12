class CreateProducers < ActiveRecord::Migration
  def change
    create_table :producers do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
    add_index :producers, :name, unique: true
    add_index :producers, :slug, unique: true
  end
end
