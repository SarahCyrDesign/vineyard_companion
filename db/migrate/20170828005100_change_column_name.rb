class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :wines, :type, :color
  end
end
