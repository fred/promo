class MessageMailer < ActionMailer::Base
  default :from => "root@globalpeacenow.com"
  
  def new_message(message)
    @message = message
    @url  = "http://globalpeacenow.com/admin/messages"
    mail(:to => "admin@heyu.net",
         :subject => "New Message at globalpeacenow.com")
  end
end
