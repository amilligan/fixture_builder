class Universe < ActiveHash::Base
  include ActiveHash::Associations

  has_many :galaxies
end