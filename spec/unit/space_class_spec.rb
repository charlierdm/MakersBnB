require './lib/space.rb'

describe Space do

  describe ".all" do
    it 'returns a list of spaces' do
      add_to_spaces()
      spaces = Space.all
      puts spaces
      expect(spaces.first).to be_a Space
      expect(spaces.first.name).to eq 'Schrute Farms'
      expect(spaces.first.description).to eq 'Despite what a Mr. Gareth Keenan may have indicated in his review, Schrute Farms is a safe destination for all travelers!'
      expect(spaces.first.price).to eq '57'
    end
  end

  describe ".create" do
    it 'creates a new space' do
      result = Space.create(name: 'Schrute Farms', description: 'Despite what a Mr. Gareth Keenan may have indicated in his review, Schrute Farms is a safe destination for all travelers!', user_id: 1234, price: '57', available_from: 'Today', available_to: 'Tomorrow')
      expect(result.name).to eq 'Schrute Farms'
      expect(result.description).to eq 'Despite what a Mr. Gareth Keenan may have indicated in his review, Schrute Farms is a safe destination for all travelers!'
      expect(result.price).to eq '57'
    end
  end

  describe '.find' do
    it 'finds a specific space'


  end


end
