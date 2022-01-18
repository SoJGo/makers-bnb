require 'space'
require 'database_helpers'

describe Space do
  describe '.create' do
    it 'creates a space with name, desc and ppn' do
      space = Space.create('Seaside Space', 'The perfect space for a getaway', 100)

      persisted_data = persisted_data(table: spaces, id: space.id)
      
      expect(space).to eq 'Seaside Space' 
      expect(space.name).to eq persisted_data['name']
      expect(space.description).to eq 'The perfect space for a getaway'
      expect(space.price).to eq 100
    end
  end
end
