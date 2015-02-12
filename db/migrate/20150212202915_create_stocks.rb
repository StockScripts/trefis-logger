class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.text :company
      t.text :sector
      t.text :industry

      t.timestamps
    end
  end
end
