require 'rails_helper'

describe Marvel::Client do
  let(:client) { marvel_test_client }

  context 'Character endpoints' do
    let(:id) { 1009652 }

    describe '#characters' do
      before do
        stub_get('characters', returns: 'characters/characters.json')
      end

      it 'fetches a list of characters' do
        expect(client.characters.size).to eq 20
        expect(client.characters.map(&:name).take(3))
          .to eq ['3-D Man', 'A-Bomb (HAS)', 'A.I.M.']
      end

      it 'requests public/v1/characters successfully' do
        expect(client.characters.status).to eq 'Ok'
      end

      it 'returns an [ Hashie::Mash ]' do
        expect(client.characters).to be_an Array
        expect(client.characters.sample).to be_a Hashie::Mash
      end
    end

    describe '#character' do
      before do
        stub_get("characters/#{id}", returns: 'characters/character.json')
      end

      it 'fetches a single character by id' do
        expect(client.character(id).size).to eq 1
        expect(client.character(id).pop.name).to eq 'Thanos'
      end

      it 'requests public/v1/characters/#{id} successfully' do
        expect(client.character(id).status).to eq 'Ok'
      end

      it 'returns an [ Hashie::Mash ]' do
        expect(client.character(id)).to be_an Array
        expect(client.character(id).sample).to be_a Hashie::Mash
      end
    end
  end
end