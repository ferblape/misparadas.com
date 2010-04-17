# == Schema Information
#
# Table name: bus_stops
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)     
#  emt_id     :integer(4)      
#  longitude  :float           
#  latitude   :float           
#  created_at :datetime        
#  updated_at :datetime        
#

class BusStop < ActiveRecord::Base
  require 'net/http'
  require 'uri'
  acts_as_mappable :lat_column_name => :latitude,
                   :lng_column_name => :longitude,
                   :default_units => :kms
                   
  Arrival = Struct.new("Arrival", :estimated_time, :bus_route)
  
  def address
    
  end
  
  def arrivals
    url = URI.parse("http://servicios.emtmadrid.es:8080/paradas/service.asmx/ObtenEstimacion?IdCliente=500002&PassKey=8ED5BB02-4BFA-4365-8348-ADA1D76E30A2&IdParada=#{self.emt_id}")
    res = Net::HTTP.get(url)
    res.split('Lin.')[1..-1].collect{|line| line.split(':')}.join(" / ")
  end
  
end
