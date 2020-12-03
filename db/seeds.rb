# 1o passo - apagar banco de dados antigo
puts "DESTROY ALL xxx"
Review.destroy_all
Rental.destroy_all
Garage.destroy_all
User.destroy_all

# 2o passo - criação dos USERS
30.times do
  new_user = User.create(
    email: Faker::Internet.email,
    password: "123456",
    name: Faker::Name.name
  )
  puts "<< USER: #{new_user.name} - created"
end

# 3o passo - criação das GARAGES
20.times do
  new_address = Faker::Address.street_name
  new_garage = Garage.create(
    title: "#{%w[Nice Clean Good New].sample} garage in #{new_address} street",
    address: new_address,
    price: rand(10.0..100.0),
    user_id: rand(1..30),
    description: "Area: #{rand(8..30)}m² \b
                  Height: #{rand(2..5)}m \b
                  About: #{Faker::Lorem.sentences}"
  )
  puts "<< GARAGE: #{new_garage.title} - created"
end

# 4o passo - criação das RENTALS
i = Garage.first.id
10.times do
  new_date = Date.today + rand(-180..180)
  new_rental = Rental.create(
    user_id: rand(User.first.id..User.last.id),
    garage_id: i,
    start_date: new_date,
    end_date: new_date + 30
    # status: true
  )
  new_review = Review.create(
    rating: rand(1..5),
    content: Faker::Lorem.sentences,
    rental_id: new_rental.id
  )
  i += 1
  puts "<< RENTAL: #{new_rental.id} - created"
  puts "<< REVIEW: #{new_review.id} - created"
end

# 5o passo - criação das RENTALS com data final vazia

5.times do
  new_date = Date.today + rand(-180..180)
  new_rental = Rental.create(
    user_id: rand(User.first.id..User.last.id),
    garage_id: i,
    start_date: new_date,
    end_date: nil
    # status: true
  )
  i += 1
  puts "<< RENTAL: #{new_rental.id} - created"
end
