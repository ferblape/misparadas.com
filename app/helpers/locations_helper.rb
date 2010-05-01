module LocationsHelper
  
  def distance_in_meters(location)
    location.respond_to?(:distance) && "( a #{number_with_precision(location.distance.to_f*1000, :precision => 2)} m.)" || nil
  end

  def favourite_class_if(bool)
    bool ? 'favourite' : ''
  end
  
end
