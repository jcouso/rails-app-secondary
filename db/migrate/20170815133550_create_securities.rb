class CreateSecurities < ActiveRecord::Migration[5.0]
  def change
    create_table :securities do |t|
      t.references :user, foreign_key: true
      t.references :issuer, foreign_key: true
      t.references :security_type, foreign_key: true
      t.string :mode
      t.string :name
      t.string :code
      t.decimal :value
      t.date :maturity
      t.decimal :price
      t.date :date_limit
      t.string :status

      t.timestamps
    end
  end
end
