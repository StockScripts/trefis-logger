class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :trefis_analyst_price
      t.integer :market_price
      t.integer :stock_id

      t.timestamps
    end
  end
end
