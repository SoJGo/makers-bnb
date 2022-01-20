require 'user'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(name: 'May McMaker', username: 'MayMcMaker', email: 'May@example.com', password: 'Marbles123')

      persisted_data = persisted_data(table: 'users')

      expect(user).to be_a User
      expect(user.id).to eq persisted_data['id']
      expect(user.username).to eq 'MayMcMaker'
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('Marbles123')
      User.create(name: 'May McMaker', username: 'MayMcMaker', email: 'May@example.com', password: 'Marbles123')
    end
  end

  describe '.find' do
    it 'finds a user by ID' do
      user = User.create(name: 'May McMaker', username: 'MayMcMaker', email: 'May@example.com', password: 'Marbles123')

      result = User.find(id: user.id)
  
      expect(result.id).to eq user.id
      expect(result.username).to eq 'MayMcMaker'
    end
  end

  describe '.authenticate' do
    context 'user exists and gives the correct email and password' do
      it 'returns the user' do
        user = User.create(name: 'May McMaker', username: 'MayMcMaker', email: 'May@example.com', password: 'Marbles123')

        authenticated_user = User.authenticate(email: 'May@example.com', password: 'Marbles123')
    
        expect(authenticated_user.id).to eq user.id
      end
    end

    context 'user gives a non-existent email' do
      it 'returns nil' do
        user = User.create(name: 'May McMaker', username: 'MayMcMaker', email: 'May@example.com', password: 'Marbles123')

        expect(User.authenticate(email: 'Moy@eximple.com', password: 'Marbles123')).to be_nil
      end
    end

    context 'user gives an incorrect passowrd' do
      it 'returns nil' do
        user = User.create(name: 'May McMaker', username: 'MayMcMaker', email: 'May@example.com', password: 'Marbles123')

        expect(User.authenticate(email: 'May@example.com', password: 'Yoyos123')).to be_nil
      end
    end
  end
end
