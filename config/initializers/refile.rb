require 'aws-sdk-s3'

if Rails.env.production?
  s3_client = Aws::S3::Resource.new(
    region: ENV['AWS_REGION'],
    credentials: Aws::Credentials.new(
      ENV['AWS_ACCESS_KEY_ID'],
      ENV['AWS_SECRET_ACCESS_KEY']
    )
  )

  Refile.cache = Refile::S3.new(
    bucket: ENV['AWS_BUCKET'],
    client: s3_client
  )
  
  Refile.store = Refile::S3.new(
    bucket: ENV['AWS_BUCKET'],
    client: s3_client
  )
end
