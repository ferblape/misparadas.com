class BusStopsController < ApplicationController
  
  def index
    @bus_stops = []
    if params[:code]
      @bus_stop = BusStop.find_by_emt_id(params[:code].strip)
      render @bus_stop
    elsif params[:address]
      @bus_stops = BusStop.find(:all, :origin => params[:address].strip, :within => 0.2, :order => 'distance ASC')
    end
  end

  def show
  end
  
end
