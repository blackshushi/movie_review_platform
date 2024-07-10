module Api
  class MoviesController < ApplicationController
    def index
      @movies = Movie.all
      render json: @movies.to_json(only: [:title, :description, :year], include: {reviews:{only: [:rating, :comment]}})
    end

    def show
      @movie = Movie.find(params[:id])
      render json: @movie.to_json(only: [:title, :description, :year], include: {reviews:{only: [:rating, :comment]}})
    end
  end
end
