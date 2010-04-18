class LocationsController < ApplicationController

  def index
    if params[:q].present?
      begin
        @locations = Location.find(:all, interpret_search_params(params))
        if @locations.empty?
          flash[:alert] = "No hemos encontrado paradas en la dirección que has indicado. Revisa la sintaxis, y si crees que es correcta prueba a poner más información, como calle, o plaza"
        end
      rescue
        @locations = []
      end
    else
      @locations = []
      flash[:alert] = "Debes de indicar una dirección física. Por ejemplo: Paseo Recoletos"
    end
  end

  def arrivals
    @location = Location.find(params[:id])
    respond_to do |wants|
      wants.json {  render :json => @location.route_arrivals.to_json }
    end
  end

  def show
  end

  private
    def interpret_search_params(params)
      if params[:q] =~ /^\s*\d{1,4}\s*$/
        return { :conditions => { :emt_code => params[:q].strip } }
      else
        return :origin => parsed_address(params[:q]), :within => 0.2, :order => 'distance ASC'
      end
    end
    
    def parsed_address(address)
      address.strip!
      if address =~ /(.*)\s*,\s*Madrid\s*/i
        address
      else
        "#{address}, Madrid"
      end
    end
end
