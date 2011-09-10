class AddIpToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :user_agent, :string
    add_column :messages, :referrer, :string
    add_column :messages, :remote_ip, :string
    add_column :messages, :extra, :string
  end

  def self.down
    remove_column :messages, :user_agent
    remove_column :messages, :referrer
    remove_column :messages, :remote_ip
    remove_column :messages, :extra
  end
end
