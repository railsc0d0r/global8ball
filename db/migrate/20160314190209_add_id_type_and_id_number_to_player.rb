class AddIdTypeAndIdNumberToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :id_type, :string
    add_column :players, :id_number, :string
  end
end
