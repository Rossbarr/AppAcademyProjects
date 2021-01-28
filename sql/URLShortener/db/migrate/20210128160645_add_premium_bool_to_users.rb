class AddPremiumBoolToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column(:users, :premium, :boolean, {default: false, null: false})
  end
end
