class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.remove :password
      t.string :crypted_password
      t.string :salt
    end

    add_index :users, :email, unique: true
  end
end
