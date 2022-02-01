class CreateGuardians < ActiveRecord::Migration[6.0]
  def change
    create_table :guardians do |t|
      t.string :full_name, null: false
      t.string :email, null: false
      t.string :address, null: false
      t.string :country, null: false
      t.string :city, null: false

      t.timestamps
    end
  end
end
