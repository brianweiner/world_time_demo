class CountryExhibit < DisplayCase::Exhibit
  def self.applicable_to?(object, context)
    object.class.name == 'Country'
  end
end