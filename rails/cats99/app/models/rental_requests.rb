class RentalRequests < ApplicationRecord

  STATUSES = ["PENDING", "APPROVED", "DENIED"]

  validates(:cat_id, presence: true)
  validates(:start_date, presence: true)
  validates(:end_date, presence: true)
  validates(:status, presence: true, inclusion: STATUSES)
  validate(:end_date_is_after_start_date, :does_not_overlap_approved_requests)

  belongs_to(:cat,
    class_name: 'Cat',
    primary_key: :id,
    foreign_key: :cat_id
  )

  delegate(:owner, to: :cat)


  def end_date_is_after_start_date
    unless self.end_date > self.start_date
      errors.add(:end_date, "must be after start date")
    end
  end

  def overlapping_requests
    RentalRequests
      .where(cat_id: self.cat_id)
      .where.not("end_date < ? or start_date > ?", self.start_date, self.end_date)
      .where.not(id: self.id)
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def does_not_overlap_approved_requests
    if overlapping_approved_requests.length > 0
      errors.add(:start_date, "overlaps with an existing approved request")
    end
  end

  def approve!
    status = "APPROVED"
    puts "Status: approved"
    overlapping_pending_requests.each(&:deny!)
    update_attributes(status: "APPROVED")
  end

  def deny!
    status = "DENIED"
    update_attributes(status: "DENIED")
  end

  def pending?
    status == "PENDING"
  end
end
