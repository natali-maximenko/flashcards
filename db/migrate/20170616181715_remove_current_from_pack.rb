class RemoveCurrentFromPack < ActiveRecord::Migration[5.1]
  def change
    remove_column :packs, :current
  end
end
