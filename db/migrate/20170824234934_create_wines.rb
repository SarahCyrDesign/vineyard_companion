class CreateWines < ActiveRecord::Migration[5.1]
  def change
    create_table :wines do |t|
      t.string :name
      t.integer :vineyard_id
      t.integer :price_per_bottle
      t.string :type
      t.text :scent
      t.text :taste
      t.text :summary
      t.string :rating
    end
  end
end
