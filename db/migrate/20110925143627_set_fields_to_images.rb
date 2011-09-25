class SetFieldsToImages < ActiveRecord::Migration
  def self.up
    Image.update_all(:published => true, :gallery => true, :featured => false)
  end

  def self.down
  end
end
