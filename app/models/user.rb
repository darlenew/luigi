require 'digest'

class User < ActiveRecord::Base

  def password=(password)
    self.encrypted_password = encrypt(password)
  end

  def verify_password(password)
    encrypt(password) == encrypted_password
  end

  def encrypt(password)
    Digest::SHA256.hexdigest(password)
  end

  def to_s
    email
  end   

end

__END__

user = User.new
user.email = 'dwong@tango.me'
user.password = 'mypassword'
    .encrypted_password
