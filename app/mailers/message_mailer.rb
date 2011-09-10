class MessageMailer < ActionMailer::Base
  default :from => "root@host.com"
  
  def new_message(message)
    @message = message
    @url  = "http://host.com/admin/messages"
    mail(:to => "admin@heyu.net",
         :subject => "New Message at host.com")
  end
end
