require 'pg'

class Space
  attr_reader :id, :name, :description, :price

  def initialize(id:, name:, description:, price:)
    @id = id
    @name = name
    @description = description
    @price = price
  end

  def self.create(name:, description:, price:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makers_bnb_test')
    else
      connection = PG.connect(dbname: 'makers_bnb')
    end
   
    result = connection.exec_params(
      "INSERT INTO spaces(name, description, price) VALUES ($1, $2, $3) RETURNING id, name, description, price;", 
      [name, description, price]
    )
    Space.new(id: result[0]['id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'])
  end
  
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makers_bnb_test')
    else
      connection = PG.connect(dbname: 'makers_bnb')
    end
    result = connection.exec('SELECT * FROM spaces;')
    p "RESULT", result
    result.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], price: space['price'])
    end
  end 
end
