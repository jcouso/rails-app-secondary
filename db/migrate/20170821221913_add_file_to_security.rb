class AddFileToSecurity < ActiveRecord::Migration[5.0]
  def change
    add_column :securities, :file, :string
  end
end
