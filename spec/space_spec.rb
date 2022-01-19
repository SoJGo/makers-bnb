require 'space'
require 'database_helpers'

describe Space do
  
  describe '.create' do
    it 'creates a space with name, desc and ppn' do
      space = Space.create(name: 'Seaside Space', description: 'The perfect space for a getaway', price: 100)

      persisted_data = persisted_data(id: space.id)
      
      expect(space).to be_a Space 
      expect(space.id).to eq persisted_data['id']
      expect(space.description).to eq 'The perfect space for a getaway'
      expect(space.price).to eq '100'
    end
  end

  describe '.find' do
    it 'finds a space by id' do
      space = Space.create(name: 'Seaside Space', description: 'The perfect space for a getaway', price: 100)

      found_space = Space.find(space.id)

      expect(found_space.name).to eq 'Seaside Space'
    end
  end
end
