class AddMoreVariablesToSecurities < ActiveRecord::Migration[5.0]
  def change
    add_column :securities, :quantity, :integer
    add_column :securities, :rate, :decimal
    add_column :securities, :unit_price, :decimal
    add_column :securities, :indexer, :string
  end
end
