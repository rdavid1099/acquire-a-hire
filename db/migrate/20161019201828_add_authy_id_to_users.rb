class AddAuthyIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :authy_id, :string
  end
end
