class MoviesController < ApplicationController
  def index
    if !@movies.nil?
      return
    end

    @movies = Movie.sort_by_rating
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def search
    @movies = Movie.search_by_actor(params[:actor_name])

    render :index
  end
end
