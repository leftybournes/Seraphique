require "faker"

rand(1000..1500).times do
    date = Faker::Date.between(from: 5.years.ago, to: Date.today)
    User.create(
        full_name: Faker::Name.unique.name,
        email: Faker::Internet.unique.email,
        password: "password",
        created_at: date,
        updated_at: date
    )
end
