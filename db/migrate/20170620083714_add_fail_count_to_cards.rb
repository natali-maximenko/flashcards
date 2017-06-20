class AddFailCountToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :fail_count, :integer, default: 0
  end
end
