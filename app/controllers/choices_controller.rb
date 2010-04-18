class ChoicesController < ApplicationController

  def index
    @choices = choices_from_slug || choices_from_cookie || (redirect_to locations_path and return)
  end

  def create
    slug = session[:choices_slug] || Choice.generate_slug
    
    @choice = Choice.new(:location_id => params[:location_id], :slug => slug)

    if @choice.save
      session[:choices_slug] = @choice.slug
      flash[:notice] = "We have added your bus stop as a favourite"
      redirect_to choices_path
    else
      flash[:error] = "We couldn't save your bus stop"
      redirect_to :back
    end
  end

  def update
    @choice = Choice.find(params[:id])
    if @choice.update_attributes(params[:choice])
      flash[:notice] = "We have added your bus stop as a favourite"
      redirect_to choices_path
    else
      flash[:error] = "We couldn't save your bus stop"
      redirect_to :back
    end
  end

  def destroy
    @choice = Choice.find(params[:id])
    if @choice.destroy
      redirect_to choices_path
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
      choices = Choice.find_all_by_slug(session[:choices_slug])
      choices.present? && choices || nil
    end

end
