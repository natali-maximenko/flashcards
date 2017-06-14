class AddAttachmentPictureToCards < ActiveRecord::Migration[5.1]
  def change
    change_table :cards do |t|
      t.attachment :picture
    end
  end
end
