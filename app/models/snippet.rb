class Snippet < Page
  
  def to_param
    permalink.parameterize
  end
  
  
end
