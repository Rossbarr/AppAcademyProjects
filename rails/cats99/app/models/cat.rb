class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  
  COLORS = ["white", "silver", "grey", "black", "yellow", "orange", "red", "brown"]

  validates(:name, presence: true)
  validates(:sex, presence: true)
  validates(:color, presence: true, inclusion: COLORS)
  validates(:birth_date, presence: true)
  validates(:user_id, presence: true)

  has_many(:requests,
    class_name: "RentalRequests",
    primary_key: :id,
    foreign_key: :cat_id,
    dependent: :destroy
  )

  belongs_to(:owner,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

  def age
    time_ago_in_words(self.birth_date)
  end
end
