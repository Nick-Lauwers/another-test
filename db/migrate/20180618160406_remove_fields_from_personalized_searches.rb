class RemoveFieldsFromPersonalizedSearches < ActiveRecord::Migration
  def change
    remove_column :personalized_searches, :is_leather_seats, :boolean
    remove_column :personalized_searches, :is_sunroof, :boolean
    remove_column :personalized_searches, :is_navigation_system, :boolean
    remove_column :personalized_searches, :is_dvd_entertainment_system, :boolean
    remove_column :personalized_searches, :is_bluetooth, :boolean
    remove_column :personalized_searches, :is_backup_camera, :boolean
    remove_column :personalized_searches, :is_remote_start, :boolean
    remove_column :personalized_searches, :is_tow_package, :boolean
  end
end
