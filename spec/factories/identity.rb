FactoryGirl.define do
	factory :identity do
		provider 		"facebook"
		uid 			"100006772657323"
		token			"CAAGvaKzr9EQBAO1Dxo1LRXf7G0piZAdJw0vIQ5ZApeZAN5pgfTpnV4OscSU1Re1Rx8PVuTpfSAt682uVp1Wm0jWOIP9ypjL2tpm0is4aQmPRvSHEubZCUuYM8JnDAwRYD56VMpMZAZCvS3SXwxusfgbaxCZCnLpVwBw4qAbyrzfp90HXfP0ZBYhA9tOg1wNUehEZD"
		secret			nil
		refresh_token	nil
		expires_at		"2014-03-07 10:33:43"
	end

	factory :google_identity do
		provider 		"google"
		uid 			"100006772657323"
		token			"CAAGvaKzr9EQBAGT6UPYm1DqW1Q8mROPsmHbXWMgDrZADeDcun3CKCQZCwzgeWUu7k4L0XDRJmIN5XBKOBZCZCK4x7ZAcAGVb8hZC6hXGHqbKZA8nXd4XwwQ1yZCwt6F2rQCILMP1zGJPqtpJqXJm3AwLBUrAWt0VuRQBOLqjZArZCVFCh4D89STQVx9RYJDDpeBlEZD"
		secret			""
		refresh_token	""
		expires_at		"2014-03-04 12:11:19"
	end

	factory :linkedin_identity do
		provider 		"linkedin"
		uid 			"100006772657323"
		token			"CAAGvaKzr9EQBAGT6UPYm1DqW1Q8mROPsmHbXWMgDrZADeDcun3CKCQZCwzgeWUu7k4L0XDRJmIN5XBKOBZCZCK4x7ZAcAGVb8hZC6hXGHqbKZA8nXd4XwwQ1yZCwt6F2rQCILMP1zGJPqtpJqXJm3AwLBUrAWt0VuRQBOLqjZArZCVFCh4D89STQVx9RYJDDpeBlEZD"
		secret			""
		refresh_token	""
		expires_at		"2014-03-04 12:11:19"
	end
end