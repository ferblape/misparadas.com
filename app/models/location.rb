class Location < ActiveRecord::Base

  has_many :stops
  has_many :routes, :through => :stops
  
  acts_as_mappable  :default_units => :kms

  require 'net/http'
  require 'uri'

   def route_arrivals(name)
     url = URI.parse(AppConfig.urls.arrivals % emt_code)
     res = Net::HTTP.get(url)
     arrivals = res.split('Lin.')[1..-1].collect{|arrival| arrival.split(':')}
     arrivals.assoc(name).try(:last)
   end
     
end
