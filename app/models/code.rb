class Code < ActiveRecord::Base
  before_validation :generate_code, :add_expiration_date

  belongs_to :trip
  has_many :recommenders

  validates_presence_of :code, :expiration_date, :trip_id

  private

  def add_expiration_date
    self.expiration_date = Time.now + 2.weeks
  end

  def generate_code
    self.code = loop do
      random_token = SecureRandom.random_number.to_s.split(//).last(6).join
      break random_token unless Code.exists?(code: random_token)
    end
  end
end
