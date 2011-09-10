class AddMoreToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :link_title, :string
    add_column :pages, :meta_title, :string
    add_column :pages, :meta_keywords, :string
    add_column :pages, :meta_description, :string
    add_column :pages, :locked, :boolean, :default => true
  end

  def self.down
    remove_column :pages, :link_title
    remove_column :pages, :meta_title
    remove_column :pages, :meta_keywords
    remove_column :pages, :meta_description
    remove_column :pages, :locked
  end
end
