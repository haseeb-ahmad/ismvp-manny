json.array!(@contacts) do |contact|
  json.extract! contact, :id, :first_name, :last_name, :given_name, :photo_url, :gender, :email, :phone, :user_id, :identity_id, :network_url, :network_username, :job_title, :organization, :industry, :country, :about, :notes
  json.url contact_url(contact, format: :json)
end
