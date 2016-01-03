class ChangeLanguageAttribute < ActiveRecord::Migration
  def change
    remove_belongs_to :contents, :language, index: true
    add_column :contents, :language, :string, null: false
  end
end
