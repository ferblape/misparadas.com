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
  belongs_to :location
    
  private
  def self.generate_slug
    until Choice.find_by_slug(slug).blank?
      slug = rand(36**8).to_s(36).rjust(8,'0')
    end
    return slug
  end
end
