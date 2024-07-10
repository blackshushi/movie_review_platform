class Actor < ActiveRecord::Base
  has_many :film_locations
  has_many :movies, through: :film_locations
end
