module ExternalDb
  class Vehicle < Record
    self.table_name = 'vehicle'
    belongs_to :source

    def sync_to_vehicle
      ::Vehicle.where(scraped_id: id).first_or_initialize.tap do |v|
        v.vehicle_make_name = make
        v.dealership = source.sync_to_dealership
        v.vehicle_model_name = model
        %i[msrp year mileage mileage_numeric body_style engine exterior
        interior fuel_type transmission drivetrain stock_number vin trim_details
        description description_clean air_conditioning power_windows remote_keyless_entry
        speed_control am_fm_radio wireless_phone_connectivity fully_automatic_headlights
        variably_intermittent_wipers abs_brakes brake_assist dual_front_impact_airbags
        electronic_stability security_system traction_control power_steering ad_url].each do |f|
          v.send("#{f}=", send(f))
        end
        v.actual_price = price
        v.created_at = created
        v.posted_at = created
        v.bumped_at = created
        v.last_found_at = last_found
        
        normalized_vehicle_make_name  = make.downcase.gsub(/[^0-9a-z]/, '')
        normalized_vehicle_model_name = model.downcase.gsub(/[^0-9a-z]/, '')
        
        VehicleMake.all.each do |vehicle_make|
          if vehicle_make.name.downcase.gsub(/[^0-9a-z]/, '').in?(normalized_vehicle_make_name)
            
            v.vehicle_make = vehicle_make
            
            VehicleModel.all.each do |vehicle_model|
              if vehicle_model.name.downcase.gsub(/[^0-9a-z]/, '').in?normalized_vehicle_model_name
                v.vehicle_model = vehicle_model
              end
            end
          end
        end
        
        v.save
      end
    end
  end
end

# Vehicle.where(dealership_id: 3).each do |vehicle|
#   vehicle.latitude  = 50.0413454
#   vehicle.longitude = -113.59097220000001
#   vehicle.save
# end