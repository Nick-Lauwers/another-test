# complete

class Vehicle < ActiveRecord::Base
  
#  searchkick word_start: [:listing_name, :city], locations: [:location]

  belongs_to :user
  belongs_to :dealership
  belongs_to :vehicle_make
  belongs_to :vehicle_model
  
  has_many :purchases, dependent: :destroy
  
  # has_one :payment
  
  has_many :reviews,           dependent: :destroy
  has_many :questions,         dependent: :destroy
  has_many :photos,            dependent: :destroy
  has_many :favorite_vehicles, dependent: :destroy
  
  has_many :appointments, dependent: :destroy
  has_many :conversations, through: :appointments
  # has_many :conversations, through: :inquiries
  has_many :favorited_by,  through: :favorite_vehicles, source: :user
  
  has_many :availabilities, dependent: :destroy
  accepts_nested_attributes_for :availabilities, allow_destroy: true
  
  has_many :upgrades, dependent: :destroy
  accepts_nested_attributes_for :upgrades, allow_destroy: true
  
  has_many :special_offers, dependent: :destroy
  accepts_nested_attributes_for :special_offers, allow_destroy: true
  
  has_one :listing_score

  # MINIMUM_PHOTOS = 2

  # validate :on => :save do
  #   if self.photos.size < MINIMUM_PHOTOS
  #     errors.add :vehicle, "Must have at least #{MINIMUM_PHOTOS} photos."
  #   end
  # end
  
  # before_save      { vin.upcase! }
  # default_scope -> { order(created_at: :desc) }
  
  # validates :vehicle_make_id, :vehicle_model_id, 
  validates :year, :actual_price, :mileage_numeric, presence: true
            # :user_id, :body_style, :color, :transmission, :fuel_type, 
            # :drivetrain, :street_address, :city, :state, :seating_capacity, 
            # presence: true
  # validates :listing_name, presence: true, length: { maximum: 50 }
  # validates :summary,      presence: true
  # , length: { maximum: 600 }
  # validates :sellers_notes,                          length: { maximum: 600 }
  
  # VALID_VIN_REGEX = /[A-HJ-NPR-Za-hj-npr-z\d]{8}[\dX][A-HJ-NPR-Za-hj-npr-z\d]{3}\d{5}/
  # validates :vin, presence: true, format: { with: VALID_VIN_REGEX }
  
  geocoded_by      :address
  after_validation :geocode, if: :address_changed?
  
  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :with_vehicle_make_id,
      :with_vehicle_model_id,
      :with_city,
      :with_year_gte,
      :with_actual_price_lte,
      :with_mileage_numeric_lte,
      # :with_seating_capacity_gte,
      :with_body_style,
      :with_exterior,
      :with_interior,
      :with_fuel_type,
      :with_transmission,
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
    ]
  )
  
  scope :sorted_by, lambda { |sort_option|
    
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    
    case sort_option.to_s
    when /^price_/
      order("vehicles.price #{ direction }")
    when /^created_at_/
      order("vehicles.created_at #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
    
  scope :with_vehicle_make_id, lambda { |vehicle_make_id|
    where(vehicle_make_id: vehicle_make_id)
  }
  
  scope :with_vehicle_model_id, lambda { |vehicle_model_id|
    where(vehicle_model_id: vehicle_model_id)
  }
  
  scope :with_city, lambda { |city|
    Vehicle.near(city)
  }
  
  scope :with_year_gte, lambda { |ref_year|
    where('vehicles.year >= ?', ref_year)
  }
  
  scope :with_actual_price_lte, lambda { |ref_price|
    where('vehicles.actual_price <= ?', ref_price)
  }
  
  scope :with_mileage_numeric_lte, lambda { |ref_mileage|
    where('vehicles.mileage_numeric <= ?', ref_mileage)
  }
  
  # scope :with_seating_capacity_gte, lambda { |ref_capacity|
  #   where('vehicles.seating_capacity >= ?', ref_capacity)
  # }
  
  scope :is_van, lambda { |flag|
    return nil if 0 == flag
    where(body_style: "Van")
  }
  
  scope :with_body_style, lambda { |body_style|
    where(body_style: body_style)
  }
  
  scope :with_exterior, lambda { |exterior|
    where(exterior: exterior)
  }
  
  scope :with_interior, lambda { |interior|
    where(interior: interior)
  }
  
  scope :with_transmission, lambda { |transmission|
    where(transmission: transmission)
  }
  
  scope :with_fuel_type, lambda { |fuel_type|
    where(fuel_type: fuel_type)
  }
  
  scope :with_drivetrain, lambda { |drivetrain|
    where(drivetrain: drivetrain)
  }
  
  scope :with_air_conditioning, lambda { |flag|
    return nil if 0 == flag
    where(air_conditioning: true)
  }
  
  scope :with_power_windows, lambda { |flag|
    return nil if 0 == flag
    where(power_windows: true)
  }
  
  scope :with_remote_keyless_entry, lambda { |flag|
    return nil if 0 == flag
    where(remote_keyless_entry: true)
  }
  
  scope :with_speed_control, lambda { |flag|
    return nil if 0 == flag
    where(speed_control: true)
  }
  
  scope :with_am_fm_radio, lambda { |flag|
    return nil if 0 == flag
    where(am_fm_radio: true)
  }
  
  scope :with_wireless_phone_connectivity, lambda { |flag|
    return nil if 0 == flag
    where(wireless_phone_connectivity: true)
  }
  
  scope :with_fully_automatic_headlights, lambda { |flag|
    return nil if 0 == flag
    where(fully_automatic_headlights: true)
  }
  
  scope :with_variably_intermittent_wipers, lambda { |flag|
    return nil if 0 == flag
    where(variably_intermittent_wipers: true)
  }
  
  scope :with_abs_brakes, lambda { |flag|
    return nil if 0 == flag
    where(abs_brakes: true)
  }
  
  scope :with_brake_assist, lambda { |flag|
    return nil if 0 == flag
    where(brake_assist: true)
  }
  
  scope :with_dual_front_impact_airbags, lambda { |flag|
    return nil if 0 == flag
    where(dual_front_impact_airbags: true)
  }
  
  scope :with_electronic_stability, lambda { |flag|
    return nil if 0 == flag
    where(electronic_stability: true)
  }
  
  scope :with_security_system, lambda { |flag|
    return nil if 0 == flag
    where(security_system: true)
  }
  
  scope :with_traction_control, lambda { |flag|
    return nil if 0 == flag
    where(traction_control: true)
  }
  
  scope :with_power_steering, lambda { |flag|
    return nil if 0 == flag
    where(power_steering: true)
  }
  
  # Provides sort options
  def self.options_for_sorted_by
    [
      # ['Registration date (newest first)', 'created_at_desc'],
      # ['Registration date (oldest first)', 'created_at_asc'],
      ['Lowest Price', 'price_asc']
    ]
  end
  
  # Concatenates address fields
  def address
    
    if apartment.present?
      [street_address, apartment, city, state].compact.join(', ')
      
    else
      [street_address, city, state].compact.join(', ')
    end
  end
  
  # Returns true if address has been updated
  def address_changed?
    street_address_changed? or apartment_changed? or city_changed? or 
    state_changed?
  end
  
  # Adds location and user association to search
  def search_data
	  attributes.merge(
	    # user_name: user(&:name),
	    location: { lat: latitude, lon: longitude }
    )
  end
  
  # Computes average rating.
  def average_rating
    reviews.count == 0 ? 0 : reviews.average(:rating).round(2)
  end
  
  # Removes spaces and commas from price and mileage.
  
  def price=(val)
    write_attribute :price, val.to_s.gsub(/[\s,]/, '').to_i
  end
  
  def mileage=(val)
    write_attribute :mileage, val.to_s.gsub(/[\s,]/, '').to_i
  end
end

# Vehicle.where(dealership_id: 3).each do |vehicle|
#   vehicle.latitude = 50.041345
#   vehicle.longitude = -113.590972
#   vehicle.street_address = "25 Alberta Rd"
#   vehicle.city = "Claresholm"
#   vehicle.state = "AB"
#   vehicle.save
# end