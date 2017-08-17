class AddIssueDateToSecurities < ActiveRecord::Migration[5.0]
  def change
    add_column :securities, :issue_date, :date
  end
end
