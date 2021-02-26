class CatRentalRequests < ApplicationRecord

  STATUSES = ["PENDING", "APPROVED", "DENIED"]

  validates(:cat_id, presence: true)
  validates(:start_date, presence: true)
  validates(:end_date, presence: true)
  validates(:status, presence: true, inclusion: STATUSES)
  validates(end_date_after_start_date)

  belongs_to(:cat,
    class_name: 'Cat',
    primary_key: :id,
    foreign_key: :cat_id,
    dependent: :destroy 
  )

  def end_date_after_start_date
    self.end_date > self.start_date
  end
end
