# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(id: 1, username: "Barrett")
User.create(id: 2, username: "Peter")

Artwork.create(id: 1, artist_id: 1, title: "Game Winning Penta", image_url: "https://www.youtube.com/watch?v=rqde_UQQqq8")
Artwork.create(id: 2, artist_id: 1, title: "Getting a Quadra after my Team Loses a Fight", image_url: "https://www.youtube.com/watch?v=rLnI8bEARiM")
Artwork.create(id: 3, artist_id: 1, title: "A Not Fed Laning Phase Quadra", image_url: "https://www.youtube.com/watch?v=rSp78_Ldaic")

ArtworkShare.create(id: 1, artwork_id: 1, viewer_id: 2)
ArtworkShare.create(id: 2, artwork_id: 2, viewer_id: 2)

Comment.create(commenter_id: 2, artwork_id: 1, body: "Wow, this is really cool!")
Comment.create(commenter_id: 2, artwork_id: 2, body: "This one isn't as cool.")
