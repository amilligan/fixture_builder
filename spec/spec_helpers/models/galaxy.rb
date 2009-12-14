class Galaxy < ActiveHash::Base
  include ActiveHash::Associations

  belongs_to :universe
end