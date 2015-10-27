json.array!(@donations) do |donation|
  json.extract! donation, :id, :amount, :need_id, :donor_id
  json.url donation_url(donation, format: :json)
end
