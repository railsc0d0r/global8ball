class AddRoleReferenceToUser < ActiveRecord::Migration
  def change
    add_reference :users, :role, index: true
  end
end
