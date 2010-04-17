class BusStopsController < ApplicationController
  
  def index
    @bus_stops = []
    if params[:code]
      @bus_stop = BusStop.find_by_emt_id(params[:code].strip)
      render @bus_stop
    elsif params[:address]
      @bus_stops = BusStop.find(:all, :origin => parsed_address(params[:address]), :within => 0.2, :order => 'distance ASC')
    end
  end

  def show
  end
  
  private
  
  def parsed_address(address)
    address.strip!
    if address =~ /(.*)\s*,\s*Madrid\s*/i
      address
    else
      "#{address}, Madrid"
    end
  end
  
end
