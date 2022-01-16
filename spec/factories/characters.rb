FactoryBot.define do
  factory :character do
    hero { Faker::DcComics.hero  }
    legal_name { Faker::DcComics.name }

    description {
      terms = ""
      Random.random_number(10..20).times do
        terms << " #{Faker::Superhero.descriptor}"
      end
      terms << "."
      terms
    }
    universe_id { Random.random_number(1000..1999) }
    universe { "marvel" }
  end
end
