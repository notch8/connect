json.array!(@donors) do |donor|
  json.extract! donor, :id, :name, :image, :email, :password, :password_confirmation
  json.url donor_url(donor, format: :json)
end
