class WebComponent < ActiveRecord::Base
   attr_accessible :name, :description, :githubLink, :imageLink, :submitter, :demoLink
end
