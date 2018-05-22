class CreatePersonalizedSearches < ActiveRecord::Migration
  def change
    create_table :personalized_searches do |t|
      
      t.integer :price
      t.integer :mileage
      t.integer :year
      t.boolean :is_convertible
      t.boolean :is_coupe
      t.boolean :is_crossover
      t.boolean :is_hatchback
      t.boolean :is_minivan
      t.boolean :is_pickup
      t.boolean :is_sedan
      t.boolean :is_suv
      t.boolean :is_van
      t.boolean :is_wagon
      t.boolean :is_leather_seats
      t.boolean :is_sunroof
      t.boolean :is_navigation_system
      t.boolean :is_dvd_entertainment_system
      t.boolean :is_bluetooth
      t.boolean :is_backup_camera
      t.boolean :is_remote_start
      t.boolean :is_tow_package
      
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end