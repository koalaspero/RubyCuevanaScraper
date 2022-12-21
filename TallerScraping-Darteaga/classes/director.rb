class Director
    attr_accessor :nombre
  
    def initialize(nombre)
      @nombre = nombre
    end
  
    def guardar
      # Check if the actor already exists in the file
      if director_exists?
        puts "Director already exists in the file"
        return
      end
  
      # Append the actor to the file
      CSV.open('director.csv', 'a') do |csv|
        csv << [@nombre]
      end
    end
  
    def director_exists?
      # Read the file and check if the actor is already present
      CSV.foreach('director.csv') do |row|
        return true if row[0] == @nombre
      end
  
      return false
    end
  end