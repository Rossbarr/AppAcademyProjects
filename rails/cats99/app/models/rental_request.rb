class RentalRequest < ApplicationRecord

  STATUSES = ["PENDING", "APPROVED", "DENIED"]

  validates(:cat_id, presence: true)
  validates(:user_id, presence: true)
  validates(:start_date, presence: true)
  validates(:end_date, presence: true)
  validates(:status, presence: true, inclusion: STATUSES)
  validate(:end_date_is_after_start_date, :does_not_overlap_approved_requests, :requester_cannot_be_owner)

  belongs_to(:cat,
    class_name: 'Cat',
    primary_key: :id,
    foreign_key: :cat_id
  )

  delegate(:owner, to: :cat)

  belongs_to(:requester,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

  def end_date_is_after_start_date
    if self.start_date and self.end_date
      unless self.end_date > self.start_date
        errors.add(:end_date, "must be after start date")
      end
    end
  end

  def overlapping_requests
    RentalRequest
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
      errors.add(:base, "Dates overlap with an existing approved request")
    end
  end

  def requester_cannot_be_owner
    if self.owner.id == self.user_id
      errors.add(:base, "Requester cannot be owner")
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
