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
        urls = self.urls.includes(:visits)
        urls.each do |url|
            links[url.short_url] = url.visits.count
        end
        links.sort_by{|url, count| count}.reverse

        # urls = self
        # .urls
        # .select("shortened_urls.short_url AS url, COUNT(shortened_urls.user_id) AS num_clicks")
        # .join(:visits)
        # .group("shortened_urls.short_url")

        # urls.map do |url|
        #     [url.url, url.num_clicks]
        # end

    end
end