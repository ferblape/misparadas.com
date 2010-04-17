class ChoicesController < ApplicationController

  
  def index
    @choices = choices_from_slug || choices_from_cookie || (redirect_to bus_stops_path and return)
    # raise @choices.inspect
  end

  def create
    if params[:slug]
      @choice = Choice.create(:slug => params[:slug], :bus_stop_id => params[:bus_stop_id])
    else
      @choices = session[:choices] || {:bus_stop_ids => Set.new, :waypoint_ids => Set.new }
      
      @choices[:bus_stop_ids] << params[:bus_stop_id]
      
      session[:choices] = @choices
      
      flash[:notice] = "We have added your bus stop as a favourite"
    end
    redirect_to choices_path
  end

  def update
    if params[:slug]
      @choice = Choice.find(params[:id])
      @choice.update_attributes(params[:choice])
    else
      @choices = session[:choices]
    end
  end

  private
  def returning_user?
    params[:slug] || session[:choices]
  end
  
  def choices_from_slug
    choices = Choice.find_all_by_slug(params[:slug])
    choices.present? && choices || nil
  end
  
  def choices_from_cookie
    session[:choices] && session[:choices][:bus_stop_ids] && session[:choices][:bus_stop_ids].to_a.map {|bus_stop_id| Choice.new(:bus_stop_id => bus_stop_id)}|| nil
  end

end
