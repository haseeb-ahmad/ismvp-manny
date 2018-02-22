module ConfirmationSender
  def self.send_confirmation_to(user)
    verification_code = CodeGenerator.generate
    # user.update(twillio_verification_code: verification_code)
    user.update_columns(:twillio_verification_code => verification_code, :is_twillio_verified => false)
    # byebug
    MessageSender.send_code(user.phone_number, verification_code)
  end
end