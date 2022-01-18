require_relative 'database_connection'

class Space
  attr_reader :id, :name, :description, :price

  def initialize(id:, name:, description:, price:)
    @id = id
    @name = name
    @description = description
    @price = price
  end

  def self.create(name:, description:, price:)  
    result = DatabaseConnection.query(
      "INSERT INTO spaces(name, description, price) VALUES ($1, $2, $3) RETURNING id, name, description, price;", 
      [name, description, price]
    )
    Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'])
  end

  
  def self.all
    result = DatabaseConnection.query('SELECT * FROM spaces;')

    result.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], price: space['price'])
    end
  end 

  def self.find(id:)
    space_id = id.to_i

    result = DatabaseConnection.query("SELECT * FROM spaces WHERE id = $1;", [space_id])
    result.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], price: space['price'])
    end
  end 
end
