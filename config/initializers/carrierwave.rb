CarrierWave.configure do |config|
  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber? || Rails.env.development?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/public"
  else
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
    config.storage = :fog
    config.fog_directory    = ENV['S3_BUCKET_NAME']
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

end
