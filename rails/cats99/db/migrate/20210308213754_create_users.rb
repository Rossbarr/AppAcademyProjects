class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false, limit: 30
      t.string :password_digest, null: false
      t.string :session_token, default: nil

      t.timestamps
    end

    add_index(:users, :username, unique: true)
  end
end
