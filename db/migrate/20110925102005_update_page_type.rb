class UpdatePageType < ActiveRecord::Migration
  def self.up
    Item.where(:type => nil).update_all(:type => "Page", :unread => false)
  end

  def self.down
  end
end
