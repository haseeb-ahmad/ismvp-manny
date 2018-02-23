ActionMailer::Base.smtp_settings = {
	:address				=> "smtp.gmail.com",
	:port					=> 587,
	:domain					=> "gmail.com",
	:user_name				=> "paksols@gmail.com",
	:password				=> "123jkl123jkl",
	:authentication			=> "plain",
	:enable_starttls_auto	=> true
}