class AddPackRefToCards < ActiveRecord::Migration[5.1]
  def change
    add_reference :cards, :pack, foreign_key: true
  end
end
