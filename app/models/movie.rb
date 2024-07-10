class Movie < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :film_locations
  has_many :actors, through: :film_locations
  belongs_to :director

  validates :title, presence: true
  validates :director_id, presence: true
  validates :year, presence: true
  validates :description, presence: true

  scope :sort_by_rating, -> { left_joins(:reviews).group(:id).order('AVG(reviews.rating) DESC') }

  def self.search_by_actor(actor_name)
    actor = Actor.where("name LIKE ?", "%#{actor_name}%").first
    if actor.nil?
      return
    end

    return actor.movies.sort_by_rating.try(:uniq)
  end

  def average_rating
    reviews.average(:rating)
  end
end
