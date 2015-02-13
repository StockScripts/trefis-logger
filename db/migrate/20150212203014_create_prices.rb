class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.float :trefis_analyst_price
      t.float :market_price
      t.integer :stock_id
      t.date    :date
      t.timestamps
    end
  end
end
