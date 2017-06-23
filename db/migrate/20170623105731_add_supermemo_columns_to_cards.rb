class AddSupermemoColumnsToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :interval, :integer, default: 0
    add_column :cards, :efactor, :float, null: false, default: 2.5
  end
end
