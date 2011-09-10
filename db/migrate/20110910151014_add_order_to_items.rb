class AddOrderToItems < ActiveRecord::Migration
  def self.up
    add_column :pages, :sort_order, :integer, :default => "10", :limit => 2
  end

  def self.down
    remove_column :pages, :sort_order
  end
end
