FactoryGirl.define do
  factory :trip do
    start '2014-12-14 12:33:28'
    self.end '2014-12-14 12:33:28'
    destination_id 1

    factory :invalid_trip do
      start nil
      self.end nil
      destination_id nil
    end
  end
end
