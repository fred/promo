class AddGaleryToImage < ActiveRecord::Migration
  def self.up
    add_column :images, :gallery, :boolean, :default => true
    add_column :images, :featured, :boolean, :default => false
    add_column :images, :published, :boolean, :default => true
  end

  def self.down
    remove_column :images, :gallery
    remove_column :images, :featured
    remove_column :images, :published
  end
end
