class AddDescriptionToSecurityType < ActiveRecord::Migration[5.0]
  def change
    add_column :security_types, :description, :text
  end
end
