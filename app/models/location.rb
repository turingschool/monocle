class Location < ApplicationRecord
  belongs_to :company

  before_validation :set_status

  geocoded_by :full_address
  after_validation :geocode_with_backup

  enum status: [:pending, :approved, :rejected]

  def geocode_with_backup
    if geocode.nil?
      self.latitude, self.longitude = Geocoder.coordinates("#{city}, #{state}")
    end
  end

  def self.approved_locations
    Location.where('status = ?', '1')
  end

  def self.pending_locations
    Location.where('status = ?', '0')
  end

  def approved
    self.status = 1
    self.save
  end

  def rejected
    self.status = 2
    self.save
  end

  def full_address
    "#{street_address}, #{city_state_zip}"
  end

  def city_state_zip
    "#{city}, #{state} #{zip_code}"
  end

  def coordinates
    {lat: latitude, lng: longitude}.to_json
  end

  def full_location
    [ street_address,
      street_address_2,
      city_state_zip,
      phone ].reject(&:blank?)
  end

  def state_options
    [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]
  end


  private
    def set_status
      self.status ||= 0
    end

end
