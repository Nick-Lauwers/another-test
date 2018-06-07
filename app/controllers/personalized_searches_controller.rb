class PersonalizedSearchesController < ApplicationController
  
  before_action :logged_in_user
  before_action :get_personalized_search, except: [:new, :create, :incomplete]
  
  def new
    @personalized_search = PersonalizedSearch.new
  end
  
  def create
    
    @personalized_search = current_user.build_personalized_search personalized_search_params
    
    if @personalized_search.save
      redirect_to price_personalized_search_path(@personalized_search)
    else
      # render 'new'
    end
  end
  
  def edit
    # @user = User.find(current_user.id)
  end
  
  def update
    
    if @personalized_search.update(personalized_search_params)
      
      if params[:redirect_location].present?
        redirect_to params[:redirect_location]
      else
        redirect_to @personalized_search
      end
      
    else
      flash[:failure]  = "Please try again."
      redirect_to :back
    end
  end
  
  def show
  end
  
  def start
    @personalized_search = PersonalizedSearch.new
  end
  
  def price
    

    # if @personalized_search.save
    #   redirect_to mileage_user_personalized_search_path
    # else
    #   # render 'new'
    # end
  end
  
  def mileage
  end
  
  def year
  end
  
  def installed_options
  end
  
  private
    
    def personalized_search_params
      params.require(:personalized_search).permit(:is_convertible, :is_coupe, 
                    :is_crossover, :is_hatchback,:is_minivan, :is_pickup, 
                    :is_sedan, :is_suv, :is_wagon, :is_leather_seats, 
                    :is_sunroof, :is_navigation_system, 
                    :is_dvd_entertainment_system, :is_bluetooth, 
                    :is_backup_camera, :is_remote_start, :is_tow_package, 
                    :price, :mileage, :year)
    end
    
    # Before filters
    
    # Identifies personalized search id.
    def get_personalized_search
      @personalized_search = PersonalizedSearch.
                               find_by(user_id: current_user.id)
      # @personalized_search = current_user.personalized_search
    end
end