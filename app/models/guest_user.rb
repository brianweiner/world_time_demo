class GuestUser
  ## A NullObject we can use for a non-signed-in user. It should respond in the same way a User would
  
  def email
    "Guest"
  end

  def id
    nil
  end

end