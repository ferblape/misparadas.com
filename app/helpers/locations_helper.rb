module LocationsHelper
  
  def distance_in_meters(location)
    location.respond_to?(:distance) && "#{number_with_precision(location.distance.to_f*1000, :precision => 2)} m." || 'n/a'
  end
  
end
