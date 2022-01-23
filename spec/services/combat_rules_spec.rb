require 'rails_helper'

RSpec.describe CombatRules, type: :service do
  let(:spider_man) do
    create(:character,
           hero: 'Spider-Man',
           description: winning_word)
  end
  let(:winning_word) { 'AveryLongWordToWin' }

  let(:thor) do
    create(:character,
           hero: 'Thor',
           description: word_for_special_case)
  end
  let(:word_for_special_case) { 'Not a magic word' }

  let(:player_one) { spider_man.hero }
  let(:player_two) { thor.hero }
  let(:seed_number) { 1 }

  let(:params) do
    params = {
      'p1' => player_one,
      'p2' => player_two,
      'seed_number' => seed_number
    }
    ActionController::Parameters.new(params)
  end

  let(:winner) do
    {
      winner: player_one,
      word: spider_man.description
    }
  end

  subject { described_class.play(params) }

  describe '.play' do
    it 'declares a winner' do
      expect(subject.declare_winner.inspect).to include winning_word
    end

    context 'special words' do
      let(:winner) do
        {
          'winner' => {
            'hero' => player_two,
            'word' => thor.description,
            'won_by' => 'Super Word'
          }
        }
      end

      context 'Gamma' do
        let(:word_for_special_case) { 'Gamma' }

        it 'declares a winner' do
          expect(subject.declare_winner).to eq(winner)
        end
      end

      context 'Radioactive' do
        let(:word_for_special_case) { 'Radioactive' }

        it 'declares a winner' do
          expect(subject.declare_winner).to eq(winner)
        end
      end
    end
  end

  describe 'public methods' do
    let(:player_one) { spider_man.hero }
    let(:player_two) { thor.hero }

    let(:params) do
      params = {
        'p1' => player_one,
        'p2' => player_two,
        'seed_number' => seed_number
      }
      ActionController::Parameters.new(params)
    end

    it 'seed_number' do
      expect(subject.seed_number).to be
    end

    it 'players' do
      expect(subject.players).to be
    end

    it 'winner' do
      expect(subject.winner).to be
    end

    it 'won_by' do
      expect(subject.won_by).to be
    end

    it 'errors?' do
      expect(subject.errors).to be
    end

    it 'errors' do
      expect(subject.errors).to be
    end

    it 'combat' do
      expect(subject.combat).to be
    end

    it 'total_combats' do
      expect(subject.total_combats).to be
    end
  end
end
