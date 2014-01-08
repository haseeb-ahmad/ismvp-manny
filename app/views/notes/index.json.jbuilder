json.array!(@notes) do |note|
  json.extract! note, :id, :note
  json.url note_url(note, format: :json)
end
