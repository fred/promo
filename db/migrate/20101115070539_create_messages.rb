class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.text :body
      t.string :skype
      t.string :twitter
      t.boolean :unread, :default => true
      t.boolean :urgent, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
