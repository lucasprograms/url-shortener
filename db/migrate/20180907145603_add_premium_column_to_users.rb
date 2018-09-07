class AddPremiumColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :premium, :boolean, null: false, default: false 
  end
end
