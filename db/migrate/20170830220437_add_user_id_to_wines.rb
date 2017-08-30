class AddUserIdToWines < ActiveRecord::Migration[5.1]
  def change
    add_column :wines, :user_id, :integer
  end
end
