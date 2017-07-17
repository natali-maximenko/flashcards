class AddPicToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :picture, :string
  end
end
