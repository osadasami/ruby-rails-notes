class CreateNotesTagsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :notes, :tags do |t|
      t.index :note_id
      t.index :tag_id
    end
  end
end
