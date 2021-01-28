class CreateTaggingsAndTagTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.integer :shortened_url_id, null: false
      t.integer :tag_topic_id, null: false

      t.timestamps
    end

    create_table :tag_topics do |t|
      t.string :tag, null: false

      t.timestamps
    end

    add_foreign_key(:taggings, :shortened_urls, { column: :shortened_url_id })
    add_foreign_key(:taggings, :tag_topics,     { column: :tag_topic_id })

    add_index(:taggings, [:shortened_url_id, :tag_topic_id], unique: false)
    add_index(:tag_topics, :tag, unique: false)
  end
end
