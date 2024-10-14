users = []

rand(1000..1500).times do
    date = Faker::Date.between(from: 5.years.ago, to: Date.today)
    users.push(
        {
            full_name: Faker::Name.unique.name,
            email: Faker::Internet.unique.email,
            password: "password",
            created_at: date,
            updated_at: date
        }
    )
end

User.create(users)

User.all.each do |user|
    user_address = {
        line_1: Faker::Address.street_address,
        line_2: Faker::Address.secondary_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: Faker::Address.country,
        postal_code: Faker::Address.postcode
    }

    user.addresses.create(user_address)
end
