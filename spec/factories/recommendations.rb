FactoryGirl.define do
  factory :recommendation do
    recommender_id { create(:user).id }
    place { build(:place) }
    trip
    description 'Aracaju is a top city man, animal'
    wishlisted true
    rating 'top'

    factory :recommendation_json do
      place { attributes_for(:place) }
      recommender_id { create(:user).id }
    end
  end
end
