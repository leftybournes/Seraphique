users = []

rand(1000..1500).times do
  date = Faker::Date.between(from: 5.years.ago, to: Date.today)
  first_name = Faker::Name.first_name
  middle_name = Faker::Name.middle_name

  users.push(
    {
      first_name: "#{first_name} #{middle_name}",
      last_name: Faker::Name.last_name,
      email: Faker::Internet.unique.email,
      password: "password",
      created_at: date,
      updated_at: date
    }
  )
end

User.create(users)

User.all.each do |user|
  user.addresses.create(
    {
      user_id: user.id,
      line_1: Faker::Address.street_address,
      line_2: Faker::Address.secondary_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country,
      postal_code: Faker::Address.postcode,
      default: true
    }
  )
end
