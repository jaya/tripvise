FactoryGirl.define do
  factory :trip do
    start '2014-12-14 12:33:28'
    self.end '2014-12-14 12:33:28'
    destination { build(:destination) }

    factory :trip_json do
      destination { attributes_for(:destination) }
    end

    factory :invalid_trip do
      start nil
      self.end nil
      destination nil
    end
  end
end
