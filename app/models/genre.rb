class Genre < ActiveRecord::Base
  has_many :movie_genres
  has_many :movies, through: :movie_genres

  def self.most_popular
    Genre.all.sort_by{|genre| -genre.movies.size}.first(3).pluck :name
  end

  def self.longest_movies
    Genre.all.sort_by{|genre| -genre.movies.average(:length).to_f}.first
  end

end