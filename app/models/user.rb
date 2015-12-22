# bcrypt will generate the password hash
require 'bcrypt' # make sure 'bcrypt' is in your Gemfile

# Class in charge of interacting with user table on db
class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password
  validates_uniqueness_of :email

  property :id, Serial
  property :email, String
  property :password_digest, Text

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
