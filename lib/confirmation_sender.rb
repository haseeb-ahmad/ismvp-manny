module ConfirmationSender
  def self.send_confirmation_to(user)
    begin
      verification_code = CodeGenerator.generate
      MessageSender.send_code(user.phone_number, verification_code)
      # user.update(twillio_verification_code: verification_code)
      user.update_columns(:twillio_verification_code => verification_code, :is_twillio_verified => false)
    rescue  => e
      user.update(:is_verified_number => false)
      puts "Message not sent"
    end
  end
end