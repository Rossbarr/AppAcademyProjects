class CreateSessionTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :session_tokens do |t|
      t.integer(:user_id, null: false)
      t.string(:session_token, null: false)
      
      t.timestamps
    end

    add_foreign_key(:session_tokens, :users, on_delete: :cascade)
    add_index(:session_tokens, :user_id)
    add_index(:session_tokens, :session_token, unique: true)
  end
end
