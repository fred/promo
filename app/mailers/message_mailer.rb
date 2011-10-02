class MessageMailer < ActionMailer::Base
  default :from => "root@globalpeacenow.com"
  
  def new_message(message)
    @message = message
    @url  = "http://globalpeacenow.com/admin/messages"
    mail(:to => "mathaba@gmail.com",
         :subject => "New Message at globalpeacenow.com")
  end
end
