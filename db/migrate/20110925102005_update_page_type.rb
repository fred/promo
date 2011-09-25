class UpdatePageType < ActiveRecord::Migration
  def self.up
    Item.where(:type => nil).update_all(:type => "Page")
  end

  def self.down
  end
end
