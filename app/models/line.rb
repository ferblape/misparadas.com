class Line < ActiveRecord::Base
  
  has_many :routes
  
  validates_uniqueness_of :name
    
end
