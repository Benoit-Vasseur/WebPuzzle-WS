class WebComponent < ActiveRecord::Base
  #attr_accessible :name, :description, :githubLink, :imageLink, :submitter, :demoLink, :author, :image, :image_content_type, :image_file_name
  attr_accessible :name, :description, :githubLink, :imageLink, :submitter, :demoLink, :author, :image_id, :type
  belongs_to :submitter, :class_name => 'User', :foreign_key => 'submitter'
  #has_one :upload, :class_name => 'Upload', :foreign_key => 'image_id'

  #has_attached_file :image,
  #                  styles: {
  #                      thumb: '100x100>',
  #                      square: '200x200#',
  #                      medium: '300x300>'
  #                  }

  def serializable_hash(options={})
    options = {:exclude=> :submitter, :include => {:submitter => {:only => [:id, :name]}}}.update(options)
    super(options)
  end
end
