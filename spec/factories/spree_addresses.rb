FactoryBot.define do
  factory :spree_address, class: 'Spree::Address' do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    dni { Faker::Number.number(digits: 8) }
    phone { Faker::Number.number(digits: 8) }
    address1 { Faker::Address.street_address }
    city { Faker::Address.city_suffix }
    country { Spree::Country.default }
    state { Spree::Country.default.states.first }
    skip_validation { true }
  end
end
