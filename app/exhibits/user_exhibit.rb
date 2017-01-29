class UserExhibit < DisplayCase::Exhibit
  def self.applicable_to?(object, context)
    object.class.name == 'User' || object.class.name == 'GuestUser'
  end

end