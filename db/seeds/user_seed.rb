require "faker"

users = []

rand(1000..1500).times do
    date = Faker::Date.between(from: 5.years.ago, to: Date.today)
    users.push(
        {
            full_name: Faker::Name.unique.name,
            email: Faker::Internet.unique.email,
            password: "password"
        }
    )
end

User.create(users)
