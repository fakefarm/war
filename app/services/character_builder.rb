class CharacterBuilder

  SPARE_VILLIANS = %w[Magneto]

  def self.find(params)
    new(params).find
  end

  attr_reader :bio

  def initialize(params, payload: Payload)
    params['universe'] = params['universe'] || 'marvel'
    @params = params
    @payload = payload.new
  end

  def find
    @bio = Character.find_by(hero: player)
    return self unless @bio.nil?

    get_new_character
    self
  end

  def get_new_character
    get_from_universe
    if @payload.data?
      write_bio
    else
      typo_error
    end
  end

  def get_from_universe
    @get ||= case @params['universe']
    when 'marvel'
      get_marvel_character
    else
      []
    end
  end

  def get_marvel_character
    @characters = MARVEL.characters(nameStartsWith: player)
    if @characters.code == 200 && @characters.present?
      parse_characters
    else
      not_found_error
    end
  end

  def parse_characters
    data = @characters.map do |c|
      {
        'universe_id' => c.id,
        'hero' => parse_hero(c.name),
        'legal_name' => parse_legal_name(c.name),
        'description' => description(c.description),
        'universe' => 'marvel'
      }
    end

    @payload.data = data
  end

  def parse_characters
    data = @characters.map do |c|
      {
        'universe_id' => c.id,
        'hero' => parse_hero(c.name),
        'legal_name' => parse_legal_name(c.name),
        'description' => description(c.description),
        'universe' => 'marvel'
      }
    end

    @payload.data = data
  end

  def write_bio
    traits = @payload.data.find { |s| s['hero'].downcase == player.downcase }
    @bio ||= Character.create(traits)
  end

  def player
    @player ||= if @params['player'].nil?
                  SPARE_VILLIANS.sample
                else
                  @params['player']
                end
  end

  def typo_error
    did_you_mean = 'Did you mean ...'
    @payload.errors = "Looks like #{player} is a typo!. #{did_you_mean}"
  end

   def not_found_error
    message = "#{player} not found in #{@params['universe']} universe."
    @payload.errors = message
  end

  def description(character)
    return character if character.present?

    placeholder_description
  end

  def placeholder_description
    "#{player} sound effects during combat include: #{effects},
    #{effects}, and #{effects}. \n NOTE: This is a placeholder
    description. Please update accordingly."
  end

  def effects
    # https://www.cbr.com/the-15-most-iconic-comic-book-sound-effects/
    ['PUM-SPAK', 'PING', 'WHAAM', 'pow', 'zzzzzzap!', 'bang!', 'muhahahahahaha', 'HA HA HA HA HA HA', 'SNAP',
     'BWAH HA HA HA', 'BOOM', 'THWIP', 'BIFF! BAM! POW!', 'SNIKT'].sample
  end

  def parse_hero(character)
    return character unless character.include?(')')

    character.split('(')[0].rstrip
  end

  def parse_legal_name(character)
    return '' unless character.include?(')')

    character.split('(')[1].gsub(')', '')
  end

  def errors
    @payload.errors
  end

end
