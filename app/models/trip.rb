class Trip < ActiveRecord::Base
  before_create :generate_token

  belongs_to :user
  belongs_to :destination
  belongs_to :recommendation_type

  validates_presence_of :start, :end
  validate :start_date_cannot_be_greater_than_end

  def start_date_cannot_be_greater_than_end
    errors.add(:start, "can't be in the past") if verify_blank && start > self.end
  end

  private

  def verify_blank
    !start.blank? && !self.end.blank?
  end

  def generate_token
    self.code = loop do
      random_token = SecureRandom.hex.upcase[0..5]
      break random_token unless Trip.exists?(code: random_token)
    end
  end
end
