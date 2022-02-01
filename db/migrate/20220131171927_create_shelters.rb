class CreateShelters < ActiveRecord::Migration[6.0]
  def change
    create_table :shelters do |t|
      t.string :country, null: false
      t.string :city, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
