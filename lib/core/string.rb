class String
  
  def strip_tags
    self.gsub(/<[^>]+>/m,'')
  end
  
end
