class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
			t.attachment :image
      t.belongs_to :picturable, polymorphic: true
      t.timestamps
    end
    add_index :pictures, [:picturable_id, :picturable_type]
  end
end
