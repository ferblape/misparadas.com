class Location < ActiveRecord::Base

  has_many :stops
  has_many :routes, :through => :stops
  
  acts_as_mappable  :default_units => :kms

  def route_arrivals
    url = URI.parse(AppConfig.urls.arrivals % emt_code)
    
    pairs = Net::HTTP.get(url).strip_tags.split('Lin.')[1..-1].collect {|pair| pair.split(':')}
  
    arrivals = {}
    routes.each do |route| 
      arrivals[route.line.name] = transform_response(pairs.assoc(route.line.name).try(:last).try(:strip) || 'no disponible')
    end
    arrivals
  end

  private

  # Ent.Par. => Lllegando
  # \d.+ min. => Llega en 
  # Autobus entorno parada. => Llegando
  # sup. \d+ min. => 
  def transform_response(response)
    response.gsub!('Autobus entorno parada.', 'Llegando...')
    response.gsub!('Ent.Par.', 'Llegando...')
    response.gsub!(/^(\d+)\s+min\./, 'Llega en \1 min.')
    response.gsub!(/sup\.\sa\s(\d+)\smin\./, 'Llega en más de \1 min.')
    response
  end
end
