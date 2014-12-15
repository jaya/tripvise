FactoryGirl.define do
  factory :recommendation do
    recommender
    place { build(:place) }
    trip
    description 'Aracaju is a top city man, animal'
    wishlisted true
    rating 'top'

    factory :recommendation_json do
      place { attributes_for(:place) }
    end
  end
end
