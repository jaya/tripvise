class Code < ActiveRecord::Base
  before_validation :generate_code, :add_expiration_date

  has_many :recommenders

  validates_presence_of :code, :expiration_date, :trip_id

  private

  def add_expiration_date
    self.expiration_date = Time.now + 2.weeks
  end

  def generate_code
    self.code = loop do
      random_token = SecureRandom.hex.upcase[0..5]
      break random_token unless Code.exists?(code: random_token)
    end
  end
end
