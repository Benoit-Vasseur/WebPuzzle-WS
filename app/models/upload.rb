class Upload < ActiveRecord::Base
  has_attached_file :file,
                    styles: {
                        thumb: '100x100>',
                        square: '200x200#',
                        medium: '300x300>'
                    }
  attr_accessible :file, :file_file_name, :file_content_type, :file_file_size

  validates :file, :content_type_custom => { :content_type => ['.jpeg', '.jpg', '.gif', '.png'] }

  validates_attachment :file, :presence => true, :message => 'The upload file must be present'
  validates_attachment :file, :size => { :in => 0..1024.kilobytes, :message=> 'The upload size must not exceed 1MB' }

  def is_image?
    !(File.extname(file_file_name) =~ /\A.jpe?g|pjpeg|gif|x-png|png\Z/i).nil?
  end

  def images
      { 'thumb' => file.url(:thumb), 'square' => file.url(:square), 'medium' => file.url(:medium)} if !file.nil?
  end

  def serializable_hash(options={})
    options = {methods: :images}.update(options)
    super(options)
  end
end
