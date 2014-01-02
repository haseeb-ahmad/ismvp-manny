json.array!(@contact_notes) do |contact_note|
  json.extract! contact_note, :id, :note
  json.url contact_note_url(contact_note, format: :json)
end
