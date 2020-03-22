FactoryBot.define do
	factory :store do
		sequence(:name) { |n| Faker::Games::Zelda.location + " (#{n})" }
		address { Faker::Address.street_address }
		email { Faker::Internet.email(domain: 'example.com') }
		phone { Faker::PhoneNumber.cell_phone }
	end
end