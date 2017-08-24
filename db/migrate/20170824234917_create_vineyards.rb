class CreateVineyards < ActiveRecord::Migration[5.1]
  def change
    create_table :vineyards do |t|
      t.string :name
      t.integer :user_id
      t.string :location
      t.integer :phone_number
      t.text :review
    end
  end
end
