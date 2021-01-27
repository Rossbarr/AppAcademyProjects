class ShortenedUrl < ApplicationRecord
    validates(:long_url,    { presence: true, uniqueness: true })
    validates(:short_url,   { presence: true, uniqueness: true })
    validates(:user_id,     { presence: true })

    belongs_to(:submitter,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

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
end