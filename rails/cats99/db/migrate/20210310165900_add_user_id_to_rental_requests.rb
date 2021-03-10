class AddUserIdToRentalRequests < ActiveRecord::Migration[5.2]
  def change
    add_column(:rental_requests, :user_id, :integer, null: false)
    add_foreign_key(:rental_requests, :users)
    add_index(:rental_requests, :user_id)
  end
end
