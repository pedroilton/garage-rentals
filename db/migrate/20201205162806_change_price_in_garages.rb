class ChangePriceInGarages < ActiveRecord::Migration[6.0]
  def change
    change_column :garages, :price, :decimal, precision: 8, scale: 2
  end
end
