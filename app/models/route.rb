class Route < ActiveRecord::Base
  
  has_many :stops
  has_many :locations, :through => :stops

  belongs_to :line

  validates_presence_of :direction, :line_id

  def expected_at(location)
    "<span class='route_estimates' id='estimate_route_#{line.name}'>...</span>"
  end
  
end
