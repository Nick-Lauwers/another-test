# completed

class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  include SessionsHelper
  before_filter :get_filterrific
  after_filter :user_activity

  private
  
    # Redirects to back, or to default url if back fails.
    def redirect_to_back_or_default(default = root_url)
      
      if request.env["HTTP_REFERER"].present? and 
         request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
        redirect_to :back
        
      else
        redirect_to default
      end
    end
  
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:failure] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms profile pic upload.
    def profile_pic_upload
      unless profile_pic?
        store_location
        redirect_to profile_pic_user_path(current_user)
      end
    end
    
    # Confirms that current user is club admin.
    def club_admin
      unless current_user.
               memberships.
               where(club_id: @club.id, admin: true).
               exists?
        flash[:failure] = "Access restricted."
        redirect_to_back_or_default
      end
    end
    
    # Updates user if online.
    def user_activity
      current_user.try :touch
    end
    
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
          :with_city,
          :with_year_gte,
          :with_price_lte,
          :with_mileage_lte,
          :with_body_style,
          :with_color,
          :with_transmission,
          :with_fuel_type,
          :with_drivetrain,
          :with_backup_camera,
          :with_bluetooth,
          :with_dvd_entertainment_system,
          :with_leather_seats,
          :with_navigation_system,
          :with_remote_start,
          :with_sunroof,
          :with_tow_package
        ],
      ) or return
    end
end