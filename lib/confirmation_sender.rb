module ConfirmationSender
  def self.send_confirmation_to(phone_number,id)
    begin
      user = User.find(id)
      verification_code = CodeGenerator.generate
      MessageSender.send_code(phone_number, verification_code)
      user.update_columns(:twillio_verification_code => verification_code, :is_twillio_verified => false)
      return true
    rescue  => e
      user.update(:is_verified_number => false)
      puts "Message not sent"
      return false
    end
  end
end