class AddFieldsToPersonalizedSearches < ActiveRecord::Migration
  def change
    add_column :personalized_searches, :air_conditioning, :boolean
    add_column :personalized_searches, :power_windows, :boolean
    add_column :personalized_searches, :remote_keyless_entry, :boolean
    add_column :personalized_searches, :speed_control, :boolean
    add_column :personalized_searches, :am_fm_radio, :boolean
    add_column :personalized_searches, :wireless_phone_connectivity, :boolean
    add_column :personalized_searches, :fully_automatic_headlights, :boolean
    add_column :personalized_searches, :variably_intermittent_wipers, :boolean
    add_column :personalized_searches, :abs_brakes, :boolean
    add_column :personalized_searches, :brake_assist, :boolean
    add_column :personalized_searches, :dual_front_impact_airbags, :boolean
    add_column :personalized_searches, :electronic_stability, :boolean
    add_column :personalized_searches, :security_system, :boolean
    add_column :personalized_searches, :traction_control, :boolean
    add_column :personalized_searches, :power_steering, :boolean
  end
end
