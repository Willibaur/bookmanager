# Class in charge of interacting with tags table on db
class Tag
  include DataMapper::Resource

  has n, :links, through: Resource

  property :id, Serial
  property :name, String
end
