class RenamePageTable < ActiveRecord::Migration
  def self.up
    rename_table :pages, :items
  end

  def self.down
    rename_table :items, :pages
  end
end
