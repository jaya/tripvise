FactoryGirl.define do
  factory :trip do
    start '2014-12-14 12:33:28'
    self.end '2014-12-14 12:33:28'
    code 'ABC12'
    destination { build(:destination) }
    recommendation_type { build(:recommendation_type) }
    user

    factory :trip_json do
      destination { attributes_for(:destination) }
      recommendation_type { attributes_for(:recommendation_type) }
    end

    factory :invalid_trip do
      start nil
      self.end nil
      destination nil
      user nil
    end
  end
end
