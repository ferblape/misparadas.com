class Stop < ActiveRecord::Base
  belongs_to :route
  belongs_to :location
  
end
