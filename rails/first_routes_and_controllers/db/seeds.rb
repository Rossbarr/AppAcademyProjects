# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: "Barrett")
User.create(username: "Peter")

Artwork.create(artist_id: 1, title: "Game Winning Penta", image_url: "https://www.youtube.com/watch?v=rqde_UQQqq8")
Artwork.create(artist_id: 1, title: "Getting a Quadra after my Team Loses a Fight", image_url: "https://www.youtube.com/watch?v=rLnI8bEARiM")
Artwork.create(artist_id: 1, title: "A Not Fed Laning Phase Quadra", image_url: "https://www.youtube.com/watch?v=rSp78_Ldaic")

ArtworkShare.create(artwork_id: 1, viewer_id: 2)
ArtworkShare.create(artwork_id: 2, viewer_id: 2)