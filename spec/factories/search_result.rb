FactoryGirl.define do
  factory :search_result do 
    search_term 'Search Term'
    country     { Faker::Address.country }
    city        { Faker::Address.city }
    state       { Faker::Address.state }
    latitude    { Faker::Address.latitude }
    longitude   { Faker::Address.longitude }
    user        { nil }
  end
end