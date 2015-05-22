FactoryGirl.define do
  factory :trip do
    start '2014-12-14 12:33:28'
    self.end '2014-12-14 12:33:28'
    destination { build(:destination) }
    recommendation_type { build(:recommendation_type) }
    hidden true
    user

    factory :not_private_trip do
      hidden false
      user_id { create(:user, fb_id: '633177910141622').id }
    end

    factory :trip_json do
      destination { attributes_for(:destination) }
      recommendation_type { attributes_for(:recommendation_type) }
      user_id { create(:user).id }
    end

    factory :invalid_trip do
      start nil
      self.end nil
      destination nil
      user nil
    end
  end
end
