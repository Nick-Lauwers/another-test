class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      
      t.string      :body_style
      t.string      :color
      t.string      :transmission
      t.string      :fuel_type
      t.string      :drivetrain
      t.string      :vin
      t.string      :listing_name
      t.string      :street_address
      t.string      :apartment
      t.string      :city
      t.string      :state
      t.integer     :year
      t.integer     :price
      t.integer     :mileage
      t.integer     :seating_capacity
      t.text        :summary
      t.text        :sellers_notes
      t.boolean     :is_leather_seats
      t.boolean     :is_sunroof 
      t.boolean     :is_navigation_system 
      t.boolean     :is_dvd_entertainment_system 
      t.boolean     :is_bluetooth
      t.boolean     :is_backup_camera
      t.boolean     :is_remote_start
      t.boolean     :is_tow_package
      t.references  :user,          index: true, foreign_key: true
      t.references  :vehicle_make,  index: true, foreign_key: true
      t.references  :vehicle_model, index: true, foreign_key: true
      # t.references  :conversation, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :vehicles, [:user_id, :created_at]
  end
end