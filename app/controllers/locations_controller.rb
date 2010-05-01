class LocationsController < ApplicationController

  def index
    if params[:slug].present?
      session[:slug] = params[:slug]
    end
    
    if session[:slug].present? && params[:slug].blank? && params[:q].blank?
      redirect_to slug_path(:slug => session[:slug])
    end
    
    @choices = session[:slug] && Choice.find_all_by_slug(session[:slug], :include => :location) || []
    @choices_by_location = @choices.group_by{|choice| choice.location}
    
    if @choices.empty?
      session[:slug] = nil
    end
    
    
    if params[:q].present?
      begin
        @locations = Location.find(:all, interpret_search_params(params))
      rescue
        @locations = []
      end
    else
      @locations = []
      flash[:alert] = "Debes de indicar una dirección física. Por ejemplo: Paseo Recoletos"
    end

    @show_intro = @choices.empty? && @locations.empty?

  end

  def arrivals
    @location = Location.find(params[:id])
    respond_to do |wants|
      wants.json {  render :json => @location.route_arrivals.to_json }
    end
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
