class AddIndexerToBids < ActiveRecord::Migration[5.0]
  def change
    add_column :bids, :indexer, :string
  end
end
