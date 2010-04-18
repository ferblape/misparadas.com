class LocationsController < ApplicationController

  def index
    if params[:q].present?
      begin
        @locations = Location.find(:all, interpret_search_params(params))
      rescue
        @locations = []
      end
    else
      @locations = []
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
