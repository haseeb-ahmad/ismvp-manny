module MessageSender
  # $twillio_no = "+12243343650"

  def self.send_code(phone_number, code)
    client = Twilio::REST::Client.new(ENV['TWILLIO_ACCOUNT_SID'], ENV['TWILLIO_AUTH_TOKEN'])
    message = client.messages.create(
      from:  ENV['TWILLIO_NO'],
      to:    phone_number,
      body:  code
    )
    message.status == 'queued'
  end

  def self.valid(phone_number)
    #debugger
    client = Twilio::REST::Client.new(ENV['TWILLIO_ACCOUNT_SID'], ENV['TWILLIO_AUTH_TOKEN'])
    begin
      response =  client.lookups.phone_numbers(phone_number).fetch
      response.phone_number #if invalid, throws an exception. If valid, no problems.
      return true
    rescue => e
      return false
    end
  end
end