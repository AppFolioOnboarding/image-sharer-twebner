# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }', { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke'', movie: movies.first)

urls = [
  'https://images.pexels.com/photos/45170/kittens-cat-cat-puppy-rush-45170.jpeg',
  'https://images.pexels.com/photos/66898/elephant-cub-tsavo-kenya-66898.jpeg',
  'https://images.pexels.com/photos/40984/animal-ara-macao-beak-bird-40984.jpeg',
  'https://images.pexels.com/photos/146083/pexels-photo-146083.jpeg',
  'https://images.pexels.com/photos/247502/pexels-photo-247502.jpeg',
  'https://images.pexels.com/photos/33152/european-rabbits-bunnies-grass-wildlife.jpg',
  'https://images.pexels.com/photos/47547/squirrel-animal-cute-rodents-47547.jpeg',
  'https://images.pexels.com/photos/213399/pexels-photo-213399.jpeg',
  'https://images.pexels.com/photos/792381/pexels-photo-792381.jpeg',
  'https://images.pexels.com/photos/158471/ibis-bird-red-animals-158471.jpeg',
  'https://images.pexels.com/photos/62289/yemen-chameleon-chamaeleo-calyptratus-chameleon-reptile-62289.jpeg',
  'https://images.pexels.com/photos/434090/pexels-photo-434090.jpeg',
  'https://images.pexels.com/photos/1851164/pexels-photo-1851164.jpeg',
  'https://images.pexels.com/photos/288621/pexels-photo-288621.jpeg',
  'https://images.pexels.com/photos/208821/pexels-photo-208821.jpeg',
  'https://images.pexels.com/photos/52509/penguins-emperor-antarctic-life-52509.jpeg',
  'https://images.pexels.com/photos/1327405/pexels-photo-1327405.jpeg',
  'https://images.pexels.com/photos/1126384/pexels-photo-1126384.jpeg',
  'https://images.pexels.com/photos/2295744/pexels-photo-2295744.jpeg',
  'https://images.pexels.com/photos/53581/bald-eagles-bald-eagle-bird-of-prey-adler-53581.jpeg'
]

urls.each do |url|
  Image.create(url: url)
end
