class CreatePacks < ActiveRecord::Migration[5.1]
  def change
    create_table :packs do |t|
      t.string :name
      t.boolean :current

      t.timestamps
    end
  end
end
