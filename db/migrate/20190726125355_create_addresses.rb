class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string  :postal_code,     null: false
      t.integer :prefecture_id,   null: false
      t.string  :city,            null: false
      t.string  :address_number   
      t.string  :building_name
      t.references  :user,        null: false, foreign_key: true

      t.timestamps
    end
  end
end
