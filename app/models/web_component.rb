class WebComponent < ActiveRecord::Base
  attr_accessible :name, :description, :githubLink, :imageLink, :submitter, :demoLink, :author
  belongs_to :submitter, :class_name => 'User', :foreign_key => 'submitter'

  #def serializable_hash(options={})
  #  options = {:include => {:user => {:only => [:id, :name, :email]}}}.update(options)
  #  super(options)
  #end
end
