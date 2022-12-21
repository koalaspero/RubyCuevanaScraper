class Actor
  attr_accessor :nombre

  def initialize(nombre)
    @nombre = nombre
  end

  def guardar
    # Check if the actor already exists in the file
    if actor_exists?
      puts "Actor already exists in the file"
      return
    end

    # Append the actor to the file
    CSV.open('actor.csv', 'a') do |csv|
      csv << [@nombre]
    end
  end

  def actor_exists?
    # Read the file and check if the actor is already present
    CSV.foreach('actor.csv') do |row|
      return true if row[0] == @nombre
    end

    return false
  end
end