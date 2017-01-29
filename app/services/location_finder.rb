include Geokit::Geocoders

class LocationFinder 

  def locate(search_term)
    MultiGeocoder.geocode(search_term)
  end
end