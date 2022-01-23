require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should have_db_column(:character_id) }
  it { should have_db_column(:combat_id) }
end
