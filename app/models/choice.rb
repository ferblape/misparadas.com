# == Schema Information
#
# Table name: choices
#
#  id          :integer(4)      not null, primary key
#  slug        :string(255)     
#  bus_stop_id :integer(4)      
#  waypoint_id :integer(4)      
#  created_at  :datetime        
#  updated_at  :datetime        
#

class Choice < ActiveRecord::Base
  belongs_to :bus_stop
end
