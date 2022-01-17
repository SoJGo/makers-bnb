require 'pg'

class Space
  attr_reader :name, :description, :price

  @spaces = []

  def initialize(name, description, price)
    @name = name
    @description = description
    @price = price
  end

  def self.create(name, description, price)
    @spaces << Space.new(name, description, price)
  end

  def self.all
    @spaces
  end
end
