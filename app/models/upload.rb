class Upload < ActiveRecord::Base
  attr_accessible :file_name

  has_attached_file :file,
                    styles: {
                        thumb: '100x100>',
                        square: '200x200#',
                        medium: '300x300>'
                    }
end
