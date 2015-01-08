class Code < ActiveRecord::Base
  validates_presence_of :code, :expiration_date, :trip_id
end
