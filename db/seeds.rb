require 'open-uri'
require 'faker'

puts "Deleting all the vaccines"

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
  # file = URI.open('https://giantbomb1.cbsistatic.com/uploads/original/9/99864/2419866-nes_console_set.png')
  new_vaccine.photo.attach(io: (remote_photo_url: "https://res.cloudinary.com/dgbyx82it/image/upload/v1558722969/photos/dj_jvpipc.jpg"), filename: 'test.jpg', content_type: 'image/jpg' )
  puts remote_photo_url: "https://res.cloudinary.com/dgbyx82it/image/upload/v1558722969/photos/dj_jvpipc.jpg"
  puts "Vaccine #{new_vaccine.id} was created"
end
