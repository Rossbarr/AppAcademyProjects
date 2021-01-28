class Tagging < ApplicationRecord
    belongs_to(:tag_topic,
        class_name: 'TagTopic',
        foreign_key: :tag_topic_id,
        primary_key: :id
    )

    belongs_to(:url,
        class_name: 'ShortenedUrl',
        foreign_key: :shortened_url_id,
        primary_key: :id
    )

    def self.link_tag(shortened_url, tag_topic)
        Tagging.create(shortened_url_id: shortened_url.id, tag_topic_id: tag_topic.id)
    end
end