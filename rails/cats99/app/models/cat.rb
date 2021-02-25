class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  
  COLORS = ["white", "silver", "grey", "black", "yellow", "orange", "red", "brown"]

  validates(:name, presence: true)
  validates(:sex, presence: true)
  validates(:color, presence: true)
  validates(:birth_date, presence: true)

  def age
    time_ago_in_words(self.birth_date)
  end
end