FactoryGirl.define do
  factory :trip do
    start '2014-12-14 12:33:28'
    self.end '2014-12-14 12:33:28'
    destination { attributes_for(:destination) }

    factory :invalid_trip do
      start nil
      self.end nil
      destination nil
    end
  end
end
