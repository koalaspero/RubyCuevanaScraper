require 'open-uri' # consultar a la plataforma
require 'nokogiri' # formatear, parsear a html
require 'csv' # escribir y leer csv
require './funciones.rb'
require './classes/pelicula.rb'

class Generos

    attr_accessor :genero

    def initialize(genero)
        @genero = genero
      end

    def self.moviesGenre(link)
        
        cuevanaHTML = URI.open(link.to_s)
        datos = cuevanaHTML.read

        parsed_content = Nokogiri::HTML(datos)

        lista_menu = parsed_content.css('nav.Menu ul')
        genre_select = lista_menu.css('li.menu-item-1953')
        genre_list = genre_select.css('ul.sub-menu')

        genre_list.css('.menu-item').each do |genero|
            gen_href = genero.css('a').attr('href')
            genre = gen_href.to_s.split('/')[4]
            cuevanaMovieScraper(gen_href, genre)
        end
    end

    def self.topThreeGenre
        @@lista_generos_csv = Dir["csv_generos/*"]
        
        @@lista_generos_csv.each do |gen_file|
            rows = CSV.read(gen_file)[1..-1]
            movies = Array.new 
            puts "Top 3 en el género de #{gen_file.split('/')[1].split('.')[0]}: "
            rows.each do |movie|
                mov = Pelicula.new(movie[0],movie[1],movie[2],Pelicula.duracion(movie[3]),movie[4].to_f,movie[5])
                movies.append(mov)
            end
            
            Generos.topThreeRating(movies)
        end
    end

    def self.topThreeRating(movies)
        top = movies.sort! { |a, b|  b.rating <=> a.rating }
        topten = top[0..2]
        topten.each do |mov|
          puts "#{mov.nombre}: #{mov.rating}"
        end
    end
end