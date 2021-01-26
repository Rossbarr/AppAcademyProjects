class Person < ApplicationRecord
    belongs_to(
        :home,
        class_name: 'House',
        foreign_key: :house_id,
        primary_key: :id
    )
end