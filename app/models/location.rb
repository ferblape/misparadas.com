class Location < ActiveRecord::Base

  has_many :stops
  has_many :routes, :through => :stops
  
  acts_as_mappable  :default_units => :kms

  def route_arrivals
    url = URI.parse(AppConfig.urls.arrivals % emt_code)
    
    # Ent.Par.
    # \d.+ min.
    # 
    pairs = Net::HTTP.get(url).strip_tags.split('Lin.')[1..-1].collect {|pair| pair.split(':')}
  
    arrivals = {}
    pairs.each do  |pair|
      arrivals[pair.first.strip] = pair.last.strip
    end
    arrivals
  end

end
