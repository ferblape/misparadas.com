class ChoicesController < ApplicationController

  
  def index
    @choices = choices_from_slug || choices_from_cookie || (redirect_to locations_path and return)
  end

  def create
    if params[:slug]
      @choice = Choice.create(:slug => params[:slug], :location_id => params[:location_id])
    else
      @choices = session[:choices] || {:location_ids => Set.new}

      @choices[:location_ids] << params[:location_id]
      
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
    session[:choices] && session[:choices][:location_ids] && session[:choices][:location_ids].to_a.map {|location_id| Choice.new(:location_id => location_id)}|| nil
  end

end
