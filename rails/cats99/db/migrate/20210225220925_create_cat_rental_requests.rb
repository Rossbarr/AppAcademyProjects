class CreateCatRentalRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :cat_rental_requests do |t|
      t.integer(:cat_id, null: false)
      t.date(:start_date, null: false)
      t.date(:end_date, null: false)
      t.string(:status, null: false, default: "PENDING")
      t.timestamps()
    end

    add_foreign_key(:cat_rental_requests, :cats, column: :cat_id, on_delete: :cascade)
    add_index(:cat_rental_requests, :cat_id)
  end
end
