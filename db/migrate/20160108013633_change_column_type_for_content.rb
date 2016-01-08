class ChangeColumnTypeForContent < ActiveRecord::Migration
  def change
    change_column :contents, :content, :text
  end
end
