class Trip < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :destination
  validates_presence_of :start, :end, :destination_id
  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    errors.add(:start, "can't be in the past") if verify_blank && start > self.end
  end

  private

  def verify_blank
    !start.blank? && !self.end.blank?
  end
end
