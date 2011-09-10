class Page < ActiveRecord::Base
  
  versioned
  
  validates_presence_of :title, :permalink, :body
  
  validates_uniqueness_of :title, :permalink

  def to_param
    permalink.parameterize
  end
  
end
