class Trip < ActiveRecord::Base
  after_create :link_to_code

  belongs_to :user
  belongs_to :destination
  belongs_to :recommendation_type

  has_one :code
  has_many :recommenders

  validates_presence_of :start, :end, :user_id
  validate :start_date_cannot_be_greater_than_end

  def start_date_cannot_be_greater_than_end
    errors.add(:start, "can't be in the past") if period_is_present? && start > self.end
  end

  private

  def link_to_code
    Code.create(trip: self)
  end

  def period_is_present?
    start.present? && self.end.present?
  end
end
