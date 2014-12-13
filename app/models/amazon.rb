require 'active_support/core_ext'

class Amazon # no inheritance here bc this class does not connect to Postgres
  
  def self.get_s3_upload_key
    s3 = AWS::S3.new
    bucket = s3.buckets['dubya-blog-bucket']
    uri = bucket.objects['uploads'].url_for(:write, {expires: get_expiry, acl: 'public-read'})

    render json: uri
    
  end  

  private

  def get_expiry
    300.seconds.from_now.utc.strftime('%s')
  end

  # def self.get_s3_upload_key
  #   bucket = ENV['S3_BUCKET_NAME']
  #   access_key = ENV['AWS_ACCESS_KEY_ID']
  #   secret = ENV['AWS_SECRET_ACCESS_KEY']
  #   key = "uploads/#{SecureRandom.uuid}"
  #   expiration = 300.seconds.from_now.utc.strftime('%s')
  #   max_filesize = 2.megabytes
  #   acl = 'public-read'
  #   sas = '201' # Tells amazon to redirect after success instead of returning xml
  #   signature = Base64.encode64(
  #     "{'expiration': '#{expiration}',
  #     'conditions': [
  #       {'bucket': '#{bucket}'},
  #       {'acl': '#{acl}'},
  #       ['starts-with', '$key', '#{key}'],
  #       ['content-length-range', 1, #{max_filesize}]
  #     ]}").gsub(/\n|\r/, '')
  #   policy = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), secret, signature)).gsub(/\n| |\r/, '')
  #   return {access_key: access_key, key: key, policy: policy, signature: signature, sas: sas, bucket: bucket, acl: acl, expiration: expiration}
  # end
end