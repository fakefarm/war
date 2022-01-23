class CombatRules
  def self.play(params)
    new(params).play
  end

  Hero = Struct.new(:hero, :word, :word_length)
  SUPER_WORDS = %w[gamma radioactive lightning]

  attr_reader :players

  def initialize(params, combat_factory: CombatFactory, payload: Payload)
    @params = params
    @combat_factory = combat_factory
    @players = []
    @payload = payload.new
  end

  def play
    fight
    declare_winner
    self
  end

  def fight
    @fight ||= combat.players.each do |player|
      player_action(player)
    end
  end

  def combat
    @combat ||= @combat_factory.build(@params)
    @payload.errors = @combat.errors if @combat.errors?
    @combat
  end

  def player_action(player)
    @players << Hero.new(player.character.hero, seed_word(player), seed_word(player).length)
  end

  def declare_winner
    return special_power unless special_power.nil?

    win_by_word_length
  end

  def special_power
    player = @players.find { |p| SUPER_WORDS.include?(p.word.downcase) }
    return nil if player.nil?

    {
      'winner' => {
        'hero' => player.hero,
        'word' => player.word,
        'won_by' => 'Super Word'
      }
    }
  end

  def win_by_word_length
    {
      'winner' => {
        'hero' => word_length.hero,
        'word' => word_length.word,
        'won_by' => 'word length'
      }
    }
  end

  def word_length
    @players.sort { |p1, p2| p2.word_length <=> p1.word_length }.first
  end

  def winner
    declare_winner['winner']['hero']
  end

  def won_by
    declare_winner['winner']['won_by']
  end

  def winning_word
    declare_winner['winner']['word']
  end

  def errors
    @payload.errors.flatten.uniq
  end

  def errors?
    errors.present?
  end

  def total_combats
    Combat.all.count
  end

  def seed_word(player)
    character_description(player).split(' ')[seed_number_calculation] || ''
  end

  def character_description(player)
    player.character.description
  end

  def seed_number_calculation
    combat.seed_number.to_i - 1
  end

  def seed_number
    combat.seed_number
  end
end
