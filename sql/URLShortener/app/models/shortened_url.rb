class ShortenedUrl < ApplicationRecord
    validates(:long_url,    { presence: true, uniqueness: true })
    validates(:short_url,   { presence: true, uniqueness: true })
    validates(:user_id,     { presence: true })

    validate(:no_spamming, :nonpremium_max)

    def no_spamming
        if self.submitter.recently_submitted_urls > 5
            errors.add(:submitter, "can't submit more than 5 urls in one minute")
        end
    end

    def nonpremium_max
        if self.submitter.premium == false and self.submitter.submitted_urls.count > 5
            errors.add(:submitter, "must have premium to submit more than 5 urls")
        end
    end

    belongs_to(:submitter,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id,
    )

    has_many(:visits,
        class_name: 'Visit',
        foreign_key: :shortened_url_id,
        primary_key: :id,
        dependent: :destroy
    )

    has_many(:visitors,
        Proc.new { distinct },
        through: :visits,
        source: :visitor
    )

    has_many(:taggings,
        class_name: 'Tagging',
        foreign_key: :shortened_url_id,
        primary_key: :id,
        dependent: :destroy
    )

    has_many(:topics,
        through: :taggings,
        source: :tag_topic
    )

    def tags
        self.topics
    end

    def self.random_code
        found = false
        until found
            url_string = SecureRandom.urlsafe_base64(n = 16)
            unless ShortenedUrl.exists?(short_url: url_string)
                found = true
            end
        end
        return url_string
    end

    def self.shorten_url(long_url, user)
        short_url = ShortenedUrl.random_code
        return ShortenedUrl.create({ long_url: long_url, short_url: short_url, user_id: user.id })
    end

    def self.prune(n = 10)
        ShortenedUrl.where('updated_at < ?', n.minutes.ago).each(&:destroy)
    end

    def num_clicks
        self.visits.select(:user_id).count.destroy
    end

    def num_unique_clicks
        self.visits.select(:user_id).distinct.count
    end

    def num_recent_unique_clicks
        self.visits.select(:user_id).distinct.where({ updated_at: (10.minutes.ago)..Time.now }).count
    end
end