require 'aws-sdk-s3'

  if Rails.env.production?
    Refile.cache = Refile::Backend::S3.new(
      bucket: ENV['AWS_BUCKET'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_REGION'],
      prefix: 'cache'
    )
  
    Refile.store = Refile::Backend::S3.new(
      bucket: ENV['AWS_BUCKET'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_REGION'],
      prefix: 'store'
    )
  end
  