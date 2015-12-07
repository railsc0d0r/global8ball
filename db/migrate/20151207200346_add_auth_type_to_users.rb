class AddAuthTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_type, :string
  end
end
