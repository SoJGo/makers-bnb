require_relative 'database_connection'

class Space
  attr_reader :id, :name, :description, :price, :user_id, :start_date, :end_date

  def initialize(id:, name:, description:, price:, user_id:, start_date:, end_date:)
    @id = id
    @name = name
    @description = description
    @price = price
    @user_id = user_id
    @start_date = start_date
    @end_date = end_date
  end

  def self.create(name:, description:, price:, user_id:, start_date:, end_date:)  
    result = DatabaseConnection.query(
      "INSERT INTO spaces(name, description, price, user_id, start_date, end_date) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id, name, description, price, user_id;", 
      [name, description, price, user_id, start_date, end_date]
    )
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM spaces;')

    all_spaces = result.map do |space|
      Space.new(id: space['id'], name: space['name'], description: space['description'], 
      price: space['price'], user_id: space['user_id'], start_date: space['start_date'], end_date: space['end_date'])
    end

    available_spaces = []

    all_spaces.each do |space|
      if space.end_date > DateTime.now.strftime("%Y-%m-%d")
        available_spaces << space
      end
    end
    available_spaces
  end 

  def self.find(id:)
    space_id = id.to_i

    space = DatabaseConnection.query("SELECT * FROM spaces WHERE id = $1;", [space_id])
    
    Space.new(id: space[0]['id'], name: space[0]['name'], description: space[0]['description'], price: space[0]['price'], user_id: space[0]['user_id'], start_date: space[0]['start_date'], end_date: space[0]['end_date'])
  end 
end
