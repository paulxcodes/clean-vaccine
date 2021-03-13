require 'open-uri'
require 'faker'

puts "Deleting all the vaccines"

Reservation.delete_all
Vaccine.delete_all
User.delete_all

puts "Creating the vaccines"

paul = User.create(email: "paul@test.ca", password: "222222")

puts "#{paul.id} got created "

10.times do
  new_vaccine = Vaccine.create(
    name: Faker::Cannabis.cannabinoid,
    description: Faker::Cannabis.health_benefit,
    user_id: paul.id,
  )
  puts "Vaccine #{new_vaccine.id} was created"
end
