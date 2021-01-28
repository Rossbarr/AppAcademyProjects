class TagTopic < ApplicationRecord
    has_many(:taggings,
        class_name: 'Tagging',
        foreign_key: :tag_topic_id,
        primary_key: :id,
        dependent: :destroy
    )

    has_many(:urls,
        through: :taggings,
        source: :url
    )

    def popular_links
        links = {}
        urls = self.urls#.includes(:visits)
        urls.each do |url|
            links[url.short_url] = url.num_clicks
        end
        links
    end
end