class AddCurrentPackToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_pack_id, :integer
  end
end
