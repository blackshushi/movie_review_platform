require 'rails_helper'

def create_sample_director
  Director.create(name: "test")
end

def create_sample_user
  User.create(name: "test")
end

def create_sample_movie(title)
  Movie.create(title: title, director_id: 1, year: 2000, description: "Test")
end

def create_sample_review(rating, movie)
  Review.create(rating: rating, comment: "Test", movie: movie, user_id: 1)
end

def create_sample_actors
  actors = ["alex", "jason", "michael"]

  actors.each do |actor|
    Actor.create(name: actor)
  end
end

RSpec.describe Movie, type: :model do

  before(:all) do
    create_sample_director
    create_sample_user
    create_sample_actors
  end

  it "should calculate average rating correctly" do
    movie = create_sample_movie("Test")

    create_sample_review(1, movie)
    create_sample_review(5, movie)
    create_sample_review(3, movie)

    # 1+3+5=9, average=9/3=3
    expect(movie.average_rating).to eq(3)
  end

  it "should sort movie by average rating effiency" do
    movie1 = create_sample_movie("Test1")
    movie2 = create_sample_movie("Test2")

    create_sample_review(1, movie1)
    create_sample_review(5, movie1)
    create_sample_review(3, movie1) #average = 3

    create_sample_review(5, movie2)
    create_sample_review(5, movie2)
    create_sample_review(5, movie2) #average = 5

    expect(Movie.sort_by_rating.first).to eq(movie2)
  end

  it "should get movies by actors correctly" do
    #link actors and movies with film_locations
    alex = Actor.find_by(name: "alex")
    jason = Actor.find_by(name: "jason")
    michael = Actor.find_by(name: "michael")

    movie1 = create_sample_movie("Test1")
    movie2 = create_sample_movie("Test2")
    movie3 = create_sample_movie("Test3")
    movie4 = create_sample_movie("Test4")

    FilmLocation.create(location: "KL", country: "MY", movie: movie1, actor: alex)
    FilmLocation.create(location: "KL", country: "MY", movie: movie3, actor: alex)
    FilmLocation.create(location: "KL", country: "MY", movie: movie4, actor: alex)
    FilmLocation.create(location: "KL", country: "MY", movie: movie2, actor: jason)
    FilmLocation.create(location: "KL", country: "MY", movie: movie4, actor: jason)
    FilmLocation.create(location: "KL", country: "MY", movie: movie3, actor: michael)

    alex_movies = Movie.search_by_actor("alex")
    expect(alex_movies.length).to eq(3)
    expect(alex_movies).to include(movie1)
    expect(alex_movies).to include(movie3)
    expect(alex_movies).to include(movie4)

    jason_movies = Movie.search_by_actor("jason")
    expect(jason_movies.length).to eq(2)
    expect(jason_movies).to include(movie2)
    expect(jason_movies).to include(movie4)

    michael_movies = Movie.search_by_actor("michael")
    expect(michael_movies.length).to eq(1)
    expect(michael_movies).to include(movie3)
  end
end
