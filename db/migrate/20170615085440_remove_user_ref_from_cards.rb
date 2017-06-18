class RemoveUserRefFromCards < ActiveRecord::Migration[5.1]
  def change
    remove_reference :cards, :user, foreign_key: true
  end
end
