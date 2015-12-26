class AddNativeNameToLanguage < ActiveRecord::Migration
  def change
    add_column :languages, :native_name, :string
  end
end
