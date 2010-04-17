# == Schema Information
#
# Table name: waypoints
#
#  id           :integer(4)      not null, primary key
#  bus_route_id :integer(4)      
#  bus_stop_id  :integer(4)      
#  section      :integer(4)      
#  created_at   :datetime        
#  updated_at   :datetime        
#

class Waypoint < ActiveRecord::Base
end
