class DropUserRoles < ActiveRecord::Migration[5.0]
  def change
    drop_table :user_roles
  end
end
