class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :street2
      t.string :zip
      t.string :city
      t.string :region
      t.string :country
      t.references :person, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
