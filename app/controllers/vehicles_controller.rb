# questionable

class VehiclesController < ApplicationController
  
  before_action :logged_in_user,     except: [:show, :search, :autocomplete]
  before_action :profile_pic_upload, only:   [:new]
  before_action :get_vehicle,        only:   [:destroy, :show, :update, :basics,
                                              :details, :upgrades, :photos, 
                                              :about_you, :consumer_activity,
                                              :post, :favorite, 
                                              :sold, :undo_sold, :bump]
  
  def new
    
    @vehicle = current_user.vehicles.build
    @vehicle.availabilities.build

    # @complete = "13%"
  end
  
  def create
    
    @vehicle = current_user.vehicles.build(vehicle_params)
    
    if @vehicle.save
      
      # if params[:images]
      #   params[:images].each do |image|
      #     @vehicle.photos.create(image: image)
      #   end
      # end
      
      # @photos = @vehicle.photos
      flash[:success] = "Basics saved; Complete all remaining details, then 
                         select 'Post Vehicle'."
      redirect_to details_vehicle_path(@vehicle)
    
    else
      render 'new'
    end
  end
  
  # def destroy
  #   @vehicle.destroy
  #   flash[:success] = "Vehicle deleted"
  #   redirect_to vehicles_path
  # end
  
  # def edit
    
  #   if current_user.id == @vehicle.user.id
  #     @photos = @vehicle.photos
  #     # @complete = "100%"
    
  #   else
  #     flash[:danger] = "Access denied"
  #     redirect_to_back_or_default
  #   end
  # end

  def update
    
    if @vehicle.update(vehicle_params)
      
      # if params[:images]
      #   params[:images].each do |image|
      #     @vehicle.photos.create(image: image)
      #   end
      # end
      
      flash[:success] = "Updates saved."
    
    else
      Rails.logger.info(@vehicle.errors.messages.inspect)
      flash[:danger] = "Update failed."
      # render 'edit'
    end
    
    redirect_to :back
  end
  
  def index
    @vehicles = current_user.vehicles
  end
  
  def show
    
    @conversation = Conversation.new
    
    @user      = @vehicle.user
    @tested    = Appointment.where("vehicle_id = ? AND buyer_id = ? AND 
                                    status = ? AND date <= ?", 
                                   @vehicle.id, 
                                   current_user.id,
                                   "accepted",
                                   Time.now).present? if current_user
                                   
    @photos    = @vehicle.photos

    @reviews   = @vehicle.reviews
    @hasReview = @reviews.find_by(reviewer_id: current_user.id) if current_user
    
    @questions = @vehicle.questions

    @question = Question.new
    
    @answer = Answer.new
    
    @availabilities = @vehicle.availabilities
  end
  
  def search

    @filterrific = initialize_filterrific(
      
      Vehicle,
      params[:filterrific],
      
      select_options: {
        sorted_by:             Vehicle.options_for_sorted_by,
        # with_vehicle_make_id:  VehicleMake.options_for_select,
        # with_vehicle_model_id: VehicleModel.options_for_select
      },
      
      persistence_id: false,
      default_filter_params: {},
      
      available_filters: [
        :with_vehicle_make_id, 
        :with_vehicle_model_id,
        :with_city,
        :with_year_gte,
        :with_actual_price_lte,
        :with_mileage_numeric_lte,
        :with_body_style,
        :with_exterior,
        :with_transmission,
        :with_fuel_type,
        :with_drivetrain,
        :with_air_conditioning,
        :with_power_windows,
        :with_remote_keyless_entry,
        :with_speed_control,
        :with_am_fm_radio,
        :with_wireless_phone_connectivity,
        :with_fully_automatic_headlights,
        :with_variably_intermittent_wipers,
        :with_abs_brakes,
        :with_brake_assist,
        :with_dual_front_impact_airbags,
        :with_electronic_stability,
        :with_security_system,
        :with_traction_control,
        :with_power_steering
      ],
    ) or return
    
    @vehicles = @filterrific.find.paginate(page: params[:page], per_page: 10)
    
    @hash = Gmaps4rails.build_markers(@vehicles) do |vehicle, marker|
      
      marker.lat vehicle.latitude
      marker.lng vehicle.longitude
      
      marker.picture({
        url: "https://s3.us-east-2.amazonaws.com/online-dealership-assets/static-assets/map-marker-red.png",
        width:  32,
        height: 32
      })
      
      marker.json({ :id => vehicle.id })
    end
    
    @vehicle = Vehicle.new
    
    if current_user && current_user.personalized_search.present?
      @personalized_search = current_user.personalized_search
    else
      @personalized_search = PersonalizedSearch.new
    end
    
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end
  
  def basics
  end
  
  def details
  end
  
  def photos
    @photos = @vehicle.photos
  end
  
  def about_you
  end
  
  def consumer_activity
    
    @orders = Purchase.
                where(seller_id: current_user.id).
                where.not(processed_at: nil)
    
    @test_drives = Appointment.
                     where("seller_id = ? AND date >= ?",
                     current_user.id,
                     Time.now)
  end
  
  def post
    @vehicle.update_attribute(:posted_at, Time.now)
    flash[:success] = "#{ @vehicle.listing_name } posted!"
    redirect_to vehicles_path
  end
  
  def favorite
    
    if current_user.favorite_vehicles.exists?(vehicle:  @vehicle,
                                              is_loved: true)
      flash[:failure] = "#{ @vehicle.listing_name } has already been added to 
                         your shortlist!"
    
    elsif current_user.favorite_vehicles.exists?(vehicle: @vehicle)
      
      current_user.
        favorite_vehicles.
        where(vehicle: @vehicle).
        first.
        update_attribute(:is_loved, true)
        
      flash[:success] = "#{ @vehicle.listing_name } was added to your 
                         shortlist!"
    
    else
      
      current_user.favorites << @vehicle
      
      current_user.
        favorite_vehicles.
        where(vehicle: @vehicle).
        first.
        update_attribute(:is_loved, true)
        
      flash[:success] = "#{ @vehicle.listing_name } was added to your 
                         shortlist!"
    end
    
    redirect_to :back
  end
  
  def sold
    @vehicle.update_attribute(:sold_at, Time.now)
    flash[:success] = "#{ @vehicle.listing_name } has been marked as sold!"
    redirect_to :back
  end
  
  def undo_sold
    @vehicle.update_attribute(:sold_at, nil)
    flash[:success] = 
      "#{ @vehicle.listing_name } is now available for purchase!"
    redirect_to :back
  end
  
  def bump
    @vehicle.update_attribute(:bumped_at, Time.now)
    flash[:success] = "#{ @vehicle.listing_name } has been bumped!"
    redirect_to :back
  end
  
  def autocomplete
    render json: Vehicle.search(params[:vehicle], autocomplete: false, limit: 10).map do |vehicle|
      { listing_name: vehicle.listing_name, city: vehicle.address.city, value: vehicle.id }
    end
  end
  
  private
    
    # Gets filterrific
    def get_filterrific
      
      @filterrific = initialize_filterrific(
      
      Vehicle,
      params[:filterrific],
      
      select_options: {
        sorted_by:             Vehicle.options_for_sorted_by,
        with_vehicle_make_id:  VehicleMake.options_for_select,
        with_vehicle_model_id: VehicleModel.options_for_select
      },
      
      persistence_id: false,
      default_filter_params: {},
      
      available_filters: [
        :with_vehicle_make_id, 
        :with_vehicle_model_id,
        :with_city
      ],
    ) or return
    end
    
    def vehicle_params
      params.require(:vehicle).permit(:body_style, :color, :transmission, 
                                      :fuel_type, :drivetrain, :vin, 
                                      :listing_name, :street_address, 
                                      :apartment, :city, :state, :year, :price, 
                                      :mileage, :seating_capacity, :summary, 
                                      :sellers_notes, :is_leather_seats, 
                                      :is_sunroof, :is_navigation_system, 
                                      :is_dvd_entertainment_system, 
                                      :is_bluetooth, :is_backup_camera, 
                                      :is_remote_start, :is_tow_package, 
                                      :vehicle_make_id, :vehicle_model_id, 
                                      :bumped_at, :posted_at, :dealership_id,
                                      availabilities_attributes: [:id, :day, 
                                      :start_time, :end_time, :vehicle_id, 
                                      :_destroy], upgrades_attributes: [:id, 
                                      :title, :description, :duration, :price, 
                                      :_destroy])
    end
    
    # Before filters
    
    # Identifies vehicle id.
    def get_vehicle
      @vehicle = Vehicle.find(params[:id])
    end
end

# add wrong user tests

# http://stackoverflow.com/questions/40260125/implement-add-to-favorites
# http://stackoverflow.com/questions/5831900/wishlist-relationships-in-rails
# http://stackoverflow.com/questions/13240109/implement-add-to-favorites-in-rails-3-4