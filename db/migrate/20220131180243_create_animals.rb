class CreateAnimals < ActiveRecord::Migration[6.0]
  def change
    create_table :animals do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.string :breed, null: false
      t.decimal :weight, null: false
      t.integer :animal_type, null: false
      t.datetime :joined_at, null: false
      t.datetime :adopted_at
      t.boolean :adopted, default: false
      t.references :shelter

      t.timestamps
    end
  end
end
