class CreateGarages < ActiveRecord::Migration[6.0]
  def change
    create_table :garages do |t|
      t.string :title
      t.string :address
      t.decimal :price
      t.references :user, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
