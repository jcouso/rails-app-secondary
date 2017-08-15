class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.references :buyer, index: true
      t.references :seller, index: true
      t.references :security, foreign_key: true
      t.string :status
      t.decimal :price
      t.decimal :rate
      t.foreign_key :users, column: :buyer_id
      t.foreign_key :users, column: :seller_id

      t.timestamps
    end
  end
end
