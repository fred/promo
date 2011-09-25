class Image < ActiveRecord::Base
  
  # scope :published, where(:published => true)
  
  belongs_to :page, :foreign_key => "parent_id"
  
  # has_attached_file :document
  
  has_attached_file :data,
    :styles => {
      :galery => {:geometry => "800x800>", :quality => 92}, 
      :large => {:geometry => "360x360>", :quality => 92}, 
      :medium => {:geometry => "240x240>", :quality => 92}, 
      :small => {:geometry => "120x120>", :quality => 92}, 
      :thumb => {:geometry => "64x64#", :quality => 92},
      :mini => {:geometry => "48x48#", :quality => 92}
    },
    :convert_options => { 
      :galery => '-quality 92',
      :large => '-quality 92',
      :medium => '-quality 92',
      :small => '-quality 92',
      :thumb => '-quality 92',
      :mini => '-quality 92'
    },
    :path => ":rails_root/public/system/:attachment/:id/:style.:extension",
    :url => "/system/:attachment/:id/:style.:extension"
  
  # handling delete of image data
  attr_accessor :delete_data
  before_save { self.data = nil if self.delete_data == '1' }
  
end
