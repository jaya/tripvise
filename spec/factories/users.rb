FactoryGirl.define do
  factory :user do
    sequence(:id) { |n| n }
    name 'Angelina Jolie'
    fb_id 'ASD1231'
    fb_token 'A312D1'
    email Faker::Internet.email
    profile_picture 'http://1.bp.blogspot.com/-D8sY8_vDGl4/T5KdkqmPg4I' \
                    '/AAAAAAAAAUI/b15_zkP-4nw/s1600/Kitten-Wallpaper-3.jpeg'

    factory :duplicated_email do
      name 'Brad Pitt'
      fb_id 'ASDAS12312'
      fb_token 'DKASOPD12312'
    end

    factory :user_recommender do
      sequence(:id) { |n| n }
      name 'Will Smith'
      fb_id 'UHIAS123'
      fb_token '1021KJ'
      email Faker::Internet.email
    end

    factory :invalid_user do
      name nil
      email nil
      fb_id nil
    end
  end
end
