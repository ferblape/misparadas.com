class ChoicesController < ApplicationController

  def index
    if session[:slug] != params[:slug] && params[:slug].present?
      session[:slug] = params[:slug]
      redirect_to slug_path(:slug => session[:slug]) 
    end

    @choices = Choice.find_all_by_slug(session[:slug]) 
    if @choices.empty? 
      (redirect_to locations_path and return)
    end
  end

  def create
    session[:slug] ||= Choice.generate_slug
    
    @choice = Choice.new(:location_id => params[:location_id], :slug => session[:slug])

    if @choice.save
      flash[:notice] = "We have added your bus stop as a favourite"
      redirect_to slug_path(:slug => session[:slug])
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
      redirect_to :back
    end
  end
  
  private
    def returning_user?
      params[:slug] || session[:choices]
    end

    def load_choices
      session[:slug] = params[:slug] unless params[:slug].blank?
      choices_from_cookie
    end

    def choices_from_cookie
      choices = 
      choices.present? && choices || nil
    end

end
