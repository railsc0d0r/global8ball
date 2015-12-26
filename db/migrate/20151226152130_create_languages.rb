class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.string :i18n_code

      t.timestamps null: false
    end
  end
end
