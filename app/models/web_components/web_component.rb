class WebComponent < ActiveRecord::Base
  attr_accessible :name, :description, :githubLink, :submitter, :demoLink, :author, :imageId, :type
  belongs_to :submitter, :class_name => 'User', :foreign_key => 'submitter'
  has_one :upload, :class_name => 'Upload', :foreign_key => 'id', :primary_key => 'imageId'

  validates :name, :description, :githubLink, :type, :submitter, :author, :demoLink, :presence => true
  validates :githubLink, :name, uniqueness:true

  def imageLink
    if !self.upload.nil?
      self.upload.file(:medium)
    else
      APP_CONFIG['empty_placeholder']
    end
  end

  def serializable_hash(options={})
    options = {:methods => :imageLink, :except=> [:imageId], :include => {:submitter => {:only => [:id, :name]}}}.update(options)
    super(options)
  end
end
