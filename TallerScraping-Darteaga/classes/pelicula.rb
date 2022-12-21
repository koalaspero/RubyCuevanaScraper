class Pelicula
    attr_accessor :nombre, :genero, :anio, :duracion, :rating, :link
  
    def initialize(nombre, genero, anio, duracion, rating, link)
      @nombre = nombre
      @genero = genero
      @anio = anio
      @duracion = duracion
      @rating = rating
      @link = link
    end
  
    def guardar(file)
      if(@nombre.to_s.length > 0)
        CSV.open(file.to_s, 'a') do |csv|
          csv << [@nombre.to_s, @genero.to_s, @anio.to_s, @duracion.to_s, @rating.to_s, @link.to_s]
        end
      end
    end

    def self.duracion(dura)
      datos = dura.to_s.split(' ')
      horas = datos[0].to_s.gsub('h','')
      mins = datos[1].to_s.gsub('m','')
  
      calcuDuration = horas.to_f + (mins.to_f / 60)
      return calcuDuration
    end

    def self.readMovies
      rows = CSV.read('movies.csv')[1..-1]
      @@movies = Array.new()
      # puts rows[1][0]
      rows.each do |movie|
        mov = Pelicula.new(movie[0],movie[1],movie[2],Pelicula.duracion(movie[3]),movie[4].to_f,movie[5])
        @@movies.append(mov)
      end

    end

    def self.topTenRating
      top = @@movies.sort! { |a, b|  b.rating <=> a.rating }
      topten = top[0..9]
      topten.each do |mov|
        puts "#{mov.nombre}: #{mov.rating}"
      end
    end

    def self.toptenDuration
      top = @@movies.sort! { |a, b|  b.duracion <=> a.duracion }
      topten = top[0..9]
      topten.each do |mov|
        puts "#{mov.nombre}: #{mov.duracion.round(1)} hora(s)"
      end
    end

    def self.sortAlfabetico
      top = @@movies.sort! { |a, b|  a.nombre <=> b.nombre }
      top.each do |mov|
        puts "Título: #{mov.nombre}"
      end
    end

  end