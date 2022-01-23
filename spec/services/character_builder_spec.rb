require 'rails_helper'

RSpec.describe CharacterBuilder, type: :service do
  let(:player) { 'Spider-Man' }
  let(:universe) { 'marvel' }

  let(:params) do
    {
      'player' => player,
      'universe' => universe
    }
  end

  subject { described_class.find(params) }

  describe '.bio' do
    before do
      stub_get('characters', returns: 'character_builder_response_bio.json')
    end

    context 'when record exists' do
      before do
        create(:character, hero: player)
      end

      it 'Character bio' do
        expect(subject.bio.hero).to eq(player)
        expect(subject.bio).to eq(Character.last)
      end
    end

    context 'when new record' do
      it 'Character bio' do
        expect(subject.bio.hero).to eq(player)
        expect(subject.bio).to eq(Character.last)
      end
    end
  end

  describe '.find' do
    describe 'happy path' do
      before do
        stub_get('characters', returns: 'character_builder_response_bio.json')
      end

      context 'when record is nil' do
        it 'Adds Character' do
          expect { described_class.find(params) }.to change { Character.count }.from(0).to(1)
        end
      end

      context 'when record exists' do
        before do
          create(:character, hero: player)
        end

        it 'Returns existing Character' do
          expect { described_class.find(params) }.to_not change { Character.count }
        end

        it '#bio' do
          expect(subject.bio.hero).to eq(player)
          expect(subject.bio).to eq(Character.last)
        end
      end
    end

    describe 'errors' do
      context 'without' do
        before do
          stub_get('characters', returns: 'character_builder_response_bio.json')
        end

        it 'error' do
          expect(subject.errors).to eq([])
        end
      end

      context 'typo' do
        before do
          stub_get('characters', returns: 'characters/character_missing.json')
        end
        let(:player) { 'Xpider-man' }
        let(:error_message) do
          { result: 'Xpider-man not found.', message: 'sorry.' }
        end

        it 'error' do
          expect { described_class.find(params) }.to_not change { Character.count }
          expect(subject.errors).to_not be_empty
        end
      end
    end

    context 'when player is nil' do
      before do
        stub_get('characters', returns: 'characters/character_missing_description.json')
        instance_double('CharacterBuilder', player: 'Magneto')
      end

      let(:player) { nil }

      it 'generates a random opponent' do
        expect { described_class.find(params) }.to change { Character.count }.from(0).to(1)
        expect(Character.last.hero).to_not be_nil
      end
    end

    context 'when description is empty' do
      before do
        stub_get('characters', returns: 'characters/character_missing_description.json')
        instance_double('CharacterBuilder', player: 'Magneto')
      end

      let(:player) { 'Magneto' }
      it 'generates a random description' do
        expect { described_class.find(params) }.to change { Character.count }.from(0).to(1)
        expect(Character.last.description).to_not be_empty
      end
    end
  end
end
