class Vhs < ActiveRecord::Base
    has_many :rentals
    has_many :clients, through: :rentals
    belongs_to :movie

    after_initialize :add_serial_number

    def self.hot_from_the_press(title, year, length, director, description, female_director, genre)
        movie = Movie.create(title: title, year: year, length: length, director: director, description: description, female_director: female_director)
        movie_genre = Genre.find_or_create_by(name: genre)
        MovieGenre.create(movie_id: movie.id, genre_id:movie_genre.id)
        3.times{Vhs.create(movie_id: movie.id)}
    end

    def self.all_genres
        Genre.pluck(:name)
    end

    def self.available_now
        not_rented = Rental.where current: false
        not_rented.map { |movie| Vhs.find(movie.id) }
    end

    def self.most_used
        vhs_array = Rental.pluck(:vhs_id)
        vhs_count = Hash.new(0)
        vhs_array.each { |vhs| vhs_count[vhs] += 1}
        # vhs_count.slice(0, 3)
        vhs_count.keys.slice(0, 3).map { |tape| Vhs.find(tape) }.map { |movie| "serial number: #{movie.serial_number} | title: #{Movie.find(movie.movie_id).title}"}
    end

    private

    # generates serial number based on the title
    def add_serial_number
        serial_number = serial_number_stub
        # Converting to Base 36 can be useful when you want to generate random combinations of letters and numbers, since it counts using every number from 0 to 9 and then every letter from a to z. Read more about base 36 here: https://en.wikipedia.org/wiki/Senary#Base_36_as_senary_compression
        alphanumerics = (0...36).map{ |i| i.to_s 36 }
        13.times{|t| serial_number << alphanumerics.sample}
        self.update(serial_number: serial_number)
    end

    def long_title?
        self.movie.title && self.movie.title.length > 2
    end

    def two_part_title?
        self.movie.title.split(" ")[1] && self.movie.title.split(" ")[1].length > 2
    end

    def serial_number_stub
        return "X" if self.movie.title.nil?
        return self.movie.title.split(" ")[1][0..3].gsub(/s/, "").upcase + "-" if two_part_title?
        return self.movie.title.gsub(/s/, "").upcase + "-" unless long_title?
        self.movie.title[0..3].gsub(/s/, "").upcase + "-"
    end
end