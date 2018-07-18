class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      
      t.references :user,          index: true, foreign_key: true
      t.string     :listing_name
      t.string     :vehicle_make_name
      t.references :vehicle_make,  index: true, foreign_key: true
      t.string     :vehicle_model_name
      t.references :vehicle_model, index: true, foreign_key: true
      t.integer    :msrp
      t.integer    :actual_price
      t.integer    :year
      t.string     :mileage
      t.integer    :mileage_numeric
      t.string     :body_style
      t.string     :engine
      t.string     :exterior
      t.string     :interior
      t.string     :fuel_type
      t.string     :transmission
      t.string     :drivetrain
      t.string     :stock_number
      t.string     :vin
      t.string     :trim_details
      t.text       :description
      t.text       :description_clean
      t.boolean    :air_conditioning
      t.boolean    :power_windows
      t.boolean    :remote_keyless_entry
      t.boolean    :speed_control
      t.boolean    :am_fm_radio
      t.boolean    :wireless_phone_connectivity
      t.boolean    :fully_automatic_headlights
      t.boolean    :variably_intermittent_wipers
      t.boolean    :abs_brakes
      t.boolean    :brake_assist
      t.boolean    :dual_front_impact_airbags
      t.boolean    :electronic_stability
      t.boolean    :security_system
      t.boolean    :traction_control
      t.boolean    :power_steering
      t.string     :street_address
      t.string     :apartment
      t.string     :city
      t.string     :state
      t.string     :ad_url
      t.datetime   :last_found_at

      t.timestamps null: false
    end
    
    add_index :vehicles, [:user_id, :created_at]
  end
end