class CombatFactory
  def self.build(params)
    new(params).build
  end

  attr_reader :combat

  def initialize(params, character: CharacterBuilder, combat: Combat, payload: Payload)
    @params = params
    @character_builder = character
    @players = player_key_format(params)
    @payload = payload.new
    @combat = combat.create(seed_number: seed_number)
  end

  def build
    register_players
    self
  end

  def errors
    @payload.errors
  end

  def errors?
    errors.present?
  end

  def players
    combat.players
  end

  def seed_number
    @seed_number ||= if @params[:seed_number].nil?
                       seed_number = rand(1..9)
                       add_error("Random seed number (#{seed_number}) was generated because seed was not provided.")
                       seed_number
                     elsif @params[:seed_number].to_i > 9
                       seed_number = 9
                       add_error('Seed max number is 9.')
                       seed_number
                     elsif @params[:seed_number].to_i < 1
                       seed_number = 1
                       add_error('Seed minimum number is 1.')
                       seed_number
                     else
                       @params[:seed_number]
                     end
  end

  private

  def player_key_format(params)
    params.permit(params.keys).to_h.select do |p|
      p[0] == 'p' && (p[1..-1] =~ /^[0-9]+$/) == 0
    end
  end

  def add_error(message)
    @payload.errors = message
  end

  def register_players
    register_characters.map do |character|
      Player.create(character: character.bio, combat: @combat)
    end
  end

  def register_characters
    two_player_minimum
    @players.map.with_index do |_p, number|
      number += 1
      character = {
        'player' => @players["p#{number}"],
        'universe' => @params[:universe]
      }
      register(character)
    end
  end

  def two_player_minimum
    until @players.keys.length >= 2
      n = @players.keys.length + 1
      @players.merge!({ "p#{n}" => non_player_character.bio.hero })
    end
  end

  def non_player_character
    non_player_character = @character_builder.find({})
    add_error("Non-player_character: #{non_player_character.bio.hero} is fighting")
    non_player_character
  end

  def register(character)
    requested_player = @character_builder.find(character)
    return requested_player if requested_player.bio

    backup_player = @character_builder.find({})
    add_error(requested_player.errors)
    add_error("Backup player chosen: #{backup_player.bio.hero} instead of #{character['player']} ")

    backup_player
  end
end
