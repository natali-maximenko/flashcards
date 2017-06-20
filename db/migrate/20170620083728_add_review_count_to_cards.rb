class AddReviewCountToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :review_count, :integer, default: 0
  end
end
