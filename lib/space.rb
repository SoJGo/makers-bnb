require_relative 'database_connection'

class Space
  attr_reader :id, :name, :description, :price

  def initialize(id:, name:, description:, price:, user_id:)
    @id = id
    @name = name
    @description = description
    @price = price
    @user_id = user_id
  end

  def self.create(name:, description:, price:, user_id:)  
    result = DatabaseConnection.query(
      "INSERT INTO spaces(name, description, price, user_id) VALUES ($1, $2, $3, $4) RETURNING id, name, description, price, user_id;", 
      [name, description, price, user_id]
    )
    Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], 
    price: result[0]['price'], user_id: result[0]['user_id'])
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM spaces;')

    result.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], 
      price: space['price'], user_id: space['user_id'])
    end
  end 

  def self.find(id:)
    space_id = id.to_i

    result = DatabaseConnection.query("SELECT * FROM spaces WHERE id = $1;", [space_id])
    result.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], 
      price: space['price'], user_id: space['user_id'])
    end
  end 
end
