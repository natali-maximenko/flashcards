class AddUserRefToCards < ActiveRecord::Migration[5.1]
  def change
    add_reference :cards, :user, foreign_key: true
  end
end
