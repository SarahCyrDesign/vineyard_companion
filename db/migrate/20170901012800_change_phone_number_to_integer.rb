class ChangePhoneNumberToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :vineyards, :phone_number, :string
  end
end
