require "refile/s3"
require "aws-sdk-s3"

Aws.config.update({
  region: ENV["AWS_REGION"],
  credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])
})

s3 = Aws::S3::Resource.new
bucket = s3.bucket(ENV["AWS_BUCKET"])

Refile.cache = Refile::S3::Backend.new(
  prefix: "cache", 
  bucket: bucket
)

Refile.store = Refile::S3::Backend.new(
  prefix: "store", 
  bucket: bucket
)
