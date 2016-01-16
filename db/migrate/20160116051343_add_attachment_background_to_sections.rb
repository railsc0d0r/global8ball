class AddAttachmentBackgroundToSections < ActiveRecord::Migration
  def self.up
    change_table :sections do |t|
      t.attachment :background
    end
  end

  def self.down
    remove_attachment :sections, :background
  end
end
