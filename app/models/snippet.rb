class Snippet < Item
  
  def to_param
    permalink.parameterize
  end
  
  
end
