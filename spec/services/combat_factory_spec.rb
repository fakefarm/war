require 'rails_helper'

RSpec.describe CombatFactory, type: :service do
  let(:winning_word) { 'AveryLongWordToWin' }
  let(:spider_man) do
    create(:character,
           hero: 'Spider-Man',
           description: winning_word)
  end

  let(:seed_number) { 4 }

  let(:word_for_special_case) { 'Not a magic word' }

  before do
    stub_get('characters', returns: 'characters/character_missing_description.json')
    instance_double('CharacterBuilder', player: 'Magneto')
  end

  let(:player_one) { spider_man.hero }
  let(:player_two) { 'Magneto' }

  let(:params) do
    params = {
      p1: player_one,
      p2: player_two,
      seed_number: seed_number
    }

    ActionController::Parameters.new(params)
  end

  subject { described_class.build(params) }

  describe '.build' do
    context 'all is well' do
      it 'Builds a combat' do
        expect { described_class.build(params) }.to change { Combat.count }.from(0).to(1)
      end

      it 'Builds players' do
        expect { described_class.build(params) }.to change { Player.count }.from(0).to(2)
      end
    end

    context 'player errors' do
      before do
        stub_get('characters', returns: 'characters/character_missing_description.json')
        instance_double('CharacterBuilder', player: 'Magneto')
      end

      let(:player_one) { 'Magneto' }
      let(:seed_number) { nil }

      it 'Builds a combat' do
        expect { described_class.build(params) }.to change { Combat.count }.from(0).to(1)
      end

      it 'Builds players' do
        expect { described_class.build(params) }.to change { Player.count }.from(0).to(2)
      end

      it 'errors' do
        expect(subject.errors).to_not be_empty
      end
    end

    context 'seed errors' do
      let(:seed_number) { nil }
      it 'random number if missing' do
        expect(subject.seed_number.class).to eq Integer
      end
    end

    context 'seed errors > 9' do
      let(:seed_number) { 42 }
      it 'max is 9' do
        expect(subject.seed_number).to eq 9
      end
    end

    context 'seed errors < 1' do
      let(:seed_number) { 0 }
      it 'min is 1' do
        expect(subject.seed_number).to eq 1
      end
    end
  end

  describe 'public methods' do
    it 'combat' do
      expect(subject.combat).to be_instance_of(Combat)
    end

    it 'players' do
      expect(subject.players).to be_present
    end

    it 'errors' do
      expect(subject.errors?).to be false
    end
  end
end
