class BusRoutesController < ApplicationController
  
  def index
    @bus_routes = BusRoute.all
  end
  
end
