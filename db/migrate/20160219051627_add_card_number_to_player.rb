class AddCardNumberToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :card_number, :string
  end
end
