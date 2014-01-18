class ContentTypeCustomValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    accepted = options[:content_type]

    if !value.queued_for_write[:original].nil?
      record.errors[attribute] << "The upload must be an image" unless accepted.include? File.extname(value.queued_for_write[:original].path)
    end
  end
end