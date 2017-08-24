class AddRatingToIssuers < ActiveRecord::Migration[5.0]
  def change
    add_column :issuers, :rating, :string
  end
end
