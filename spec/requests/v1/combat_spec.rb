require 'rails_helper'
WebMock.allow_net_connect!

RSpec.describe 'V1::Combat', type: :request do
  let(:media_type) { 'application/json' }
  let(:headers) { { accept: media_type } }
  let(:spider_man_word) { 'AveryLongWordToWin' }

  let(:spider_man) do
    create(:character,
           hero: 'Spider-Man',
           description: spider_man_word)
  end

  let(:thor_word) { 'loser' }

  let(:thor) do
    create(:character,
           hero: 'Thor',
           description: thor_word)
  end

  let(:player_one) { spider_man.hero }
  let(:player_two) { thor.hero }

  let(:players) do
    [
      {
        'hero' => player_one,
        'word' => spider_man_word,
        'word_length' => spider_man_word.length
      },
      {
        'hero' => player_two,
        'word' => thor_word,
        'word_length' => thor_word.length
      }
    ]
  end
  let(:seed_number) { '1' }
  let(:won_by) { 'word length' }

  let(:payload) do
    {
      'winner' => {
        'hero' => player_one,
        'won_by' => won_by,
        'word' => spider_man_word
      },
      'meta' => {
        'total_combats' => 1,
        'seed_number' => seed_number,
        'players' => players,
        'messages' => []
      }
    }
  end

  describe 'GET /index' do
    context 'word length and seed_number' do
      before do
        get "/v1/combat?p1=#{player_one}&p2=#{player_two}&seed_number=#{seed_number}", headers: headers
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'winning_style' do
        expect(JSON.parse(response.body)).to eq payload
      end

      it 'returns expected payload' do
        expect(body).to eq(payload.to_json)
      end
    end

    context 'missing a player and seed_number' do
      before do
        get "/v1/combat?p1=#{player_one}", headers: headers
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'seed message' do
        expect(response.body).to include 'seed was not provided'
      end

      it '2 players' do
        expect(JSON.parse(response.body)['meta']['players'].count).to eq 2
      end
    end
  end
end
