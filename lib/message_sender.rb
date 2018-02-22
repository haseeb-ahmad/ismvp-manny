module MessageSender
  def self.send_code(phone_number, code)

    account_sid = "AC214fc400b254ba6331cf0ddd72780bf6" # Your Account SID from www.twilio.com/console
    auth_token = "7d1cd64743e4e26cbd2adb6daab0de2a"   # Your Auth Token from www.twilio.com/console
    twillio_no = "+12243343650"
    
    client = Twilio::REST::Client.new(account_sid, auth_token)
    message = client.messages.create(
      from:  twillio_no,
      to:    phone_number,
      body:  code
    )

    message.status == 'queued'
  end
end