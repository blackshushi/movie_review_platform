desc "Import movies"
task :import_movies => :environment do |t, args|
  filename = "tmp/movies.csv"
  if filename.nil?
    puts "Please specify the file to import"
    exit
  end

  pp "Importing data from #{filename}"

  csv = CSV.open(filename)
  # CSV.foreach(filename, headers: true) do |r|
  #   pp r
  # end
  csv.each_with_index do |r, i|
    if i == 0
      next
    end

    pp r

    director = Director.where(name: r[3]).first_or_create
    actor = Actor.where(name: r[4]).first_or_create

    movie = Movie.where(title: r[0], description: r[1], year: r[2], director_id: director.id).first_or_create

    location = FilmLocation.where(movie: movie, actor: actor, location: r[5], country: r[6]).first_or_create
  end

  pp "Imported data from #{filename} successfully"
end

desc "Import reviews"
task :import_reviews => :environment do |t, args|
  filename = "tmp/reviews.csv"
  if filename.nil?
    puts "Please specify the file to import"
    exit
  end

  pp "Importing data from #{filename}"

  csv = CSV.open(filename)
  csv.each_with_index do |r, i|
    if i == 0
      next
    end

    pp r

    movie = Movie.where(title: r[0]).first
    user = User.where(name: r[1]).first_or_create

    review = Review.where(movie: movie, user: user, rating: r[2], comment: r[3]).first_or_create
  end

  pp "Imported data from #{filename} successfully"
end
