class Artwork < ApplicationRecord
    validates(:artist_id, presence: true)
    validates(:image_url, presence: true)
    validates(:title, presence: true, uniqueness: { scope: :artist_id })

    belongs_to(:artist,
        class_name: "User",
        foreign_key: :artist_id
    )

    has_many(:shares,
        class_name: "ArtworkShare",
        foreign_key: :artwork_id,
        dependent: :destroy
    )

    has_many(:shared_viewers,
        through: :shares,
        source: :viewer
    )
end