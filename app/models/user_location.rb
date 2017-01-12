class UserLocation

  def self.coordinates(coordinates)
    {lat: coordinates[0], lng: coordinates[1] }.to_json
  end

end
