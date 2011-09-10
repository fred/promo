class Message < ActiveRecord::Base
  
  include Humanizer
  require_human_on :create
  
  validates_presence_of :name, :message => " : Please leave us your name. We would like to know your name."
  validates_presence_of :body, :message => " Message : Please type a message."
  validates_presence_of :email, :message => " : We need your email to be able to contact you."
end
