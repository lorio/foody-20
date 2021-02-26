class AddUserToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :username, :string
    add_index :recipes, :username
  end
end
