module V1
  class CombatController < ApplicationController
    include Swagger::Blocks

    swagger_path '/v1/combat' do
      operation :get do
        key :summary, 'Combat by Words'
        key :description,
            'choose players from the Marvel Universe, and a random number between 1 and 9. Response will select a term from each player\'s description. The winner is the player with the word that is either a SUPER WORD, or the longest word. SUPER Words defeat the longest word.'
        key :example, '/v1/combat?p1=hulk&p2=thor&seed_number=3'
        key :produces, [
          'application/json'
        ]
        parameter do
          key 'p[N]', "'N' is the player number"
          key :in, :query
          key :description,
              'Player number and name. If no players are added, the system will provide Non-player Characters'
          key :key_example, 'p1'
          key :query_example_with_one_player, 'p1=hulk'
          key :query_example_with_two_players, 'p1=hulk&p2=thor'
          key :type, :string
        end
        parameter do
          key :name, :seed_number
          key :in, :query
          key :description, 'choose a number beteen 1 and 9'
          key :example, 'seed_number=4'
          key :type, :integer
        end
        response 200 do
          key :description, 'combat response'
          schema do
            key :winner, {
              hero: 'String',
              won_by: 'String',
              word: 'String'
            }
            key :meta, {
              total_combats: 'Integer',
              seed_number: 'Integer',
              players: [
                {
                  hero: 'String',
                  word: 'String,',
                  word_length: 'Integer'
                },
                {
                  hero: 'String',
                  word: 'String,',
                  word_length: 'Integer'
                }
              ],
              messages: [
                'String'
              ]
            }
          end
        end
      end
    end

    def index
      @combat = CombatRules.play(params)
    end
  end
end
