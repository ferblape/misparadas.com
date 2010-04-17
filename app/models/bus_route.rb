# == Schema Information
#
# Table name: bus_routes
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)     
#  terminal_a :string(255)     
#  terminal_b :string(255)     
#  emt_id     :integer(4)      
#  created_at :datetime        
#  updated_at :datetime        
#

class BusRoute < ActiveRecord::Base
end
