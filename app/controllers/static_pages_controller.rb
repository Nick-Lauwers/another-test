# should contact be under static_pages?

class StaticPagesController < ApplicationController
  def home
  end

  def help
  end
  
  def about
  end
  
  def contact
    @enquiry = Enquiry.new
  end
  
  def how_it_works
  end
  
  def dashboard
  end
  
  def profile
  end
  
  def search
    if params[:search].present? && params[:search].strip != ""
      session[:vehicle_search] = params[:search]
    end
    
    if session[:vehicle_search] && session[:vehicle_search] != ""
      @vehicles_listing_name = 
        Vehicle.where(listing_name: session[:vehicle_search])
    else
      @vehicles_listing_name = Vehicle.all
    end
    
    @search      = @vehicles_listing_name.ransack(params[:q])
    @vehicles    = @search.result.paginate(page: params[:page], per_page: 10)
    # @arrVehicles = @vehicles.to_a
    
    # @users = User.paginate(page: params[:page])
    
    # respond_to :js
    respond_to do |format|
            format.html {}
            format.js {}
        end
  end
end

# https://techbrownbags.wordpress.com/2014/01/17/rails-ajax-search-sort-paginate-with-ransack-kaminari/
# ransack search ajax