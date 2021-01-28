class User < ApplicationRecord
    validates(:email, {presence: true, uniqueness: true})

    has_many(:submitted_urls,
        class_name: 'ShortenedUrl',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_many(:visits,
        class_name: 'Visit',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_many(:visited_urls,
        Proc.new { distinct },
        through: :visits,
        source: :visited_url
    )

    def recently_submitted_urls
        self.submitted_urls.where({ updated_at: (1.minutes.ago)..Time.now }).count
    end
end