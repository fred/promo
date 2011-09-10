class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string  :data_file_name
      t.string  :data_content_type
      t.string  :data_file_size
      t.string  :data_updated_at
      t.integer :parent_id
      t.string  :title
      t.text    :description
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
