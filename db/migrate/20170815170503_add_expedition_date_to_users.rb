class AddExpeditionDateToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :expedition_date, :date
  end
end
