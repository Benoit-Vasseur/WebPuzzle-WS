class WebComponent < ActiveRecord::Base
  attr_readonly :id
  attr_accessible :name, :description, :githubLink, :imageLink, :submitter, :demoLink
end
