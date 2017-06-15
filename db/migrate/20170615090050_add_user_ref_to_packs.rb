class AddUserRefToPacks < ActiveRecord::Migration[5.1]
  def change
    add_reference :packs, :user, foreign_key: true
  end
end
