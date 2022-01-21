require 'space'
require 'database_helpers'

describe Space do
  describe '.create' do
    it 'creates a space with name, desc and ppn' do
      Space.create(name: 'Seaside Space', description: 'The perfect space for a getaway', price: 100, user_id: 1, start_date: Date.new(2022,12,03), end_date: Date.new(2022, 12, 07))

      persisted_data = persisted_data(table: 'spaces')
      
      expect(persisted_data['name']).to eq 'Seaside Space'
      expect(persisted_data['description']).to eq 'The perfect space for a getaway'
      expect(persisted_data['price']).to eq '100'
    end
  end

  describe '.find' do
    it 'finds a space by id' do
      Space.create(name: 'Seaside Space', description: 'The perfect space for a getaway', price: 100, user_id: 1, start_date: Date.new(2022,12,03), end_date: Date.new(2022, 12, 07))

      found_space = Space.find(id: 1)

      expect(found_space.name).to eq 'Seaside Space'
      expect(found_space.description).to eq 'The perfect space for a getaway'
    end
  end
end
