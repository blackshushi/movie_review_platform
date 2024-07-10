class FilmLocation < ActiveRecord::Base
  belongs_to :movie
  belongs_to :actor

  validates :location,:country, presence: true
end
