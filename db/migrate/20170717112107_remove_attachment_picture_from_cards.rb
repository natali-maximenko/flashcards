class RemoveAttachmentPictureFromCards < ActiveRecord::Migration[5.1]
  def change
    remove_attachment :cards, :picture
  end
end
