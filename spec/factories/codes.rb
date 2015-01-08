FactoryGirl.define do
  factory :code do
    initialize_with { new(trip_id: create(:trip).id) }
  end
end
