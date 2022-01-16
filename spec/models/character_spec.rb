require 'rails_helper'

RSpec.describe Character, type: :model do
  it { should have_db_column(:hero) }
  it { should have_db_column(:legal_name) }
  it { should have_db_column(:description) }
  it { should have_db_column(:universe_id) }
  it { should have_db_column(:universe) }
end
