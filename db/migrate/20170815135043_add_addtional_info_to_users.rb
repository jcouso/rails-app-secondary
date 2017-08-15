class AddAddtionalInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :cpf, :string
    add_column :users, :document_number, :string
    add_column :users, :birthdate, :date
    add_column :users, :mother_name, :string
    add_column :users, :father_name, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :bank, :string
    add_column :users, :account_agency, :string
    add_column :users, :account_number, :string
  end
end
