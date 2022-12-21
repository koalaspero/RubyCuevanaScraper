puts "Mi Primer Scraper de Películas \u{1f3ac}"

require './classes/pelicula.rb'
require './funciones.rb'
require './generos.rb'

link = 'https://ww1.cuevana3.me/peliculas-mas-valoradas'

#Peliculas en movies.csv
cuevanaMovieScraper(link)

Pelicula.readMovies
puts "Orden Alfabético: "
Pelicula.sortAlfabetico
puts "Top 10 por rating: "
Pelicula.topTenRating
puts "Top 10 por duración: "
Pelicula.toptenDuration

#Peliculas por género
Generos.moviesGenre(link)

#Top3 peliculas por genero en rating
Generos.topThreeGenre