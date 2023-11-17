# require 'uri'
# require 'net/http'

# url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")

# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true

# request = Net::HTTP::Get.new(url)
# request["accept"] = 'application/json'
# request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMWU0YzAyZWNmMzFlZWE4N2UyMzcxODczZDAzNDk1OSIsInN1YiI6IjY1NTVmNDQxMDgxNmM3MDBhYmJkMTA0NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.h2QAgDB_i7QF46gSjRFzmp8W7weYkEVfxLsJj5EUQ3U'

# response = http.request(request)
# puts response.read_body
# movies = response.read_body

# movies.each do |movie_data|
#   Movie.create(
#     title: movie_data['title'],
#     overview: movie_data['overview'],
#     rating: movie_data['vote_average'],
#     poster_url: movie_data['poster_path']
#   )
# end

#   puts "#{movies.size} movies created."
# else
#   puts "Error: Unable to fetch movies from TMDb."
# end


require 'open-uri'
require 'json'

#Cleaning database
Movie.destroy_all

# Define the API URL
url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=a1e4c02ecf31eea87e2371873d034959'

# Open the URL and read the response
response = URI.open(url).read

# Parse the JSON response
parsed_response = JSON.parse(response)

# Seed the Movie model with the parsed data
if parsed_response && parsed_response['results']
  parsed_response['results'].each do |movie_data|
    Movie.create(
      title: movie_data['title'],
      overview: movie_data['overview'],
      rating: movie_data['vote_average'],
      poster_url: "https://image.tmdb.org/t/p/w500#{movie_data['poster_path']}"
    )
  end

  puts "#{parsed_response['results'].size} movies created."
else
  puts "Error: Unable to fetch movies from TMDb."
end
