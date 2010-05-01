class ChoicesController < ApplicationController

  def index
    if session[:slug] != params[:slug] && params[:slug].present?
      session[:slug] = params[:slug]
      redirect_to slug_path(:slug => session[:slug])
    else
      redirect_to root_path
    end

  end

  def create
    session[:slug] ||= Choice.generate_slug
    
    @choice = Choice.find_or_initialize_by_favourite_route_id_and_slug(params[:choice].merge(:slug => session[:slug]))

    if @choice.save
      flash[:notice] = "We have added your bus stop as a favourite"
    else
      flash[:error] = "We couldn't save your bus stop"
    end
    redirect_to :back
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
