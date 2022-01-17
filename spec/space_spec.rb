require 'space'

describe Space do
  describe '.create' do
    it 'creates a space with name, desc and ppn' do
      Space.create('Seaside Space', 'The perfect space for a getaway', 100)
      expect(Space.all[0].name).to eq 'Seaside Space' 
      expect(Space.all[0].description).to eq 'The perfect space for a getaway'
      expect(Space.all[0].price).to eq 100
    end
  end
end
