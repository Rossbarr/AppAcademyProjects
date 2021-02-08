class RemoveEmailOnUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column(:users, :email)
    remove_index(:users, :name)

    add_index(:users, :name, unique: true)
  end
end
