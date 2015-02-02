class NullObject
  # special method called when method is not found on an obj
  # can define what you want to happen if a method is not found
  def method_missing(*)
    self
  end

  def id
    false
  end

  # null object cannot verify password
  def verify_password(*)
    false
  end
end