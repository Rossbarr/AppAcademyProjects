class ChangeIndexOnSessionTokens < ActiveRecord::Migration[5.2]
  def change
    remove_index(:session_tokens, :session_token)
    add_index(:session_tokens, :session_token, unique: true)
  end
end
