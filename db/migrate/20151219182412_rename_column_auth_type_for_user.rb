class RenameColumnAuthTypeForUser < ActiveRecord::Migration
  def change
    rename_column :users, :auth_type, :auth_obj_type
  end
end
