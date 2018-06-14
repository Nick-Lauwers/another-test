module ExternalDb
  class Vehicle < Record
    self.table_name = 'vehicle'
    belongs_to :source

    def sync_to_vehicle
      ::Vehicle.where(scraped_id: id).first_or_initialize.tap do |v|
        v.vehicle_make_name = make
        v.dealership = find_dealership
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
        v.vehicle_make = find_vehicle_make
        v.vehicle_model = find_vehicle_model
        v.save
      end
    end

    def find_dealership
      source.sync_to_dealership
    end

    def find_vehicle_make
      VehicleMake.find_by_name(make)
    end

    def find_vehicle_model
      VehicleModel.find_by_name(model)
    end
  end
end
