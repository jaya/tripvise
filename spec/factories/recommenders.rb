FactoryGirl.define do
  factory :recommender do
    trip_id { create(:trip).id }
    code_id { create(:code).id }
    user_id { create(:user).id }
  end
end
