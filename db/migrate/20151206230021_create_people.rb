class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.string :nickname
      t.string :title
      t.string :email, null: false
      t.string :phone
      t.date :date_of_birth

      t.timestamps null: false
    end
  end
end
