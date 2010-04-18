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
        return :origin => params[:q].strip, :within => 0.2, :order => 'distance ASC'
      end
    end

end
