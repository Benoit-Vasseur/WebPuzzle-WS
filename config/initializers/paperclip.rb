Paperclip.options[:image_magick_path] = "/usr/bin"
Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:default_url] = 's3-eu-west-1.amazonaws.com'
Paperclip::Attachment.default_options[:url] = ':s3_sg_url'
Paperclip::Attachment.default_options[:path] = ':class/:id/:hash.:extension'
Paperclip::Attachment.default_options[:hash_secret] = 'WebPuzzleIsMyDevFavWebsite'
Paperclip::Attachment.default_options[:s3_protocol] = 'https'

Paperclip.interpolates(:s3_sg_url) do |att, style|
  "#{att.s3_protocol}://#{Paperclip::Attachment.default_options[:default_url]}/#{att.bucket_name}/#{att.path(style)}"
end