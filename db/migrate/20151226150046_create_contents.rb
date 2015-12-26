class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :section, index: true
      t.references :language, index: true
      t.string :headline
      t.string :content
      
      t.timestamps null: false
    end
  end
end
