require 'rails_helper'

RSpec.describe Combat, type: :model do
  it { should have_db_column(:seed_number) }
end
