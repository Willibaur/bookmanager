# bcrypt will generate the password hash
require 'bcrypt' # make sure 'bcrypt' is in your Gemfile

# Class in charge of interacting with user table on db
class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, required: true, format: :email_address, unique: true
  property :password_digest, Text

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
