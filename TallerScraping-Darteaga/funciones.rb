require 'open-uri' # consultar a la plataforma
require 'nokogiri' # formatear, parsear a html
require 'csv' # escribir y leer csv
require './classes/pelicula.rb'
require './classes/director.rb'
require './classes/actor.rb'
require './generos.rb'

def headerCreate(file)

    if(File.exists?(file))
      rows = CSV.read(file.to_s)
      # puts rows
      if(rows.length() < 1)
          CSV.open(file, 'a') do |csv|
              csv << %w[Nombre Género Año Duración Rating Link]
          end
      end
    else
      CSV.open(file, 'a') do |csv|
        csv << %w[Nombre Género Año Duración Rating Link]
      end
    end
end

def getCharacters(cadena)
    
    cadena = cadena.to_s

    conteo = cadena.count(',')
    characters = Array.new()

    if(conteo > 0)
        persons = cadena.split(',')
        persons.each do |pers|
            characters.append(pers.strip)
        end
    else 
        characters.append(cadena.strip)
    end

    return characters
end

def cuevanaMovieScraper(link, genre="")
    cuevanaHTML = URI.open(link)
    datos = cuevanaHTML.read

    if(genre.length < 1)
      headerCreate("movies.csv")
    else
      headerCreate("csv_generos/#{genre}.csv")
    end

    parsed_content = Nokogiri::HTML(datos)
  
    pelis_container = parsed_content.css('.MovieList')
    pelis_container.css('.TPost').each do |item|
      link = item.css('a:nth-child(1)').attr('href')
      # puts link
  
      movieTitle = item.css('.TPMvCn').css('.Title').inner_text
      # puts movieTitle
      movieInfo = item.css('.TPMvCn').css('.Info')
  
      vote = movieInfo.css('.Vote').inner_text
      time = movieInfo.css('.Time').inner_text
      date = movieInfo.css('.Date').inner_text
  
      movieDesc = item.css('.TPMvCn').css('.Description')
  
      direcs = movieDesc.css('.Director').inner_text
      directorText = direcs.strip.split(':')[1]
      directores = getCharacters(directorText)
      
      genres = movieDesc.css('.Genre').inner_text
      genreText = genres.strip.split(':')[1]
  
      actors = movieDesc.css('.Actors').inner_text
      actoresText = actors.strip.split(':')[1]
      actores = getCharacters(actoresText)
  
      pelicula = Pelicula.new(movieTitle, genreText, date, time, vote, link)
  
      if(genre.length < 1)
  
        pelicula.guardar('movies.csv')
  
        directores.each do |dir|
          director = Director.new(dir) 
          director.guardar
        end
        
        actores.each do |act|
          actor = Actor.new(act) 
          actor.guardar
        end
  
      else
        pelicula.guardar("csv_generos/#{genre}.csv")
      end
    end
  end