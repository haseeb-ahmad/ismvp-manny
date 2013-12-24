FACEBOOK_CONFIG = YAML.load_file("#{Rails.root}/config/facebook.yml")[Rails.env].symbolize_keys
LINKEDIN_CONFIG = YAML.load_file("#{Rails.root}/config/linkedin.yml")[Rails.env].symbolize_keys
GOOGLE_CONFIG = YAML.load_file("#{Rails.root}/config/google.yml")[Rails.env].symbolize_keys
