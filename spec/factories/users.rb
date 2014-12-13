FactoryGirl.define do
  factory :user, class: User do
    name 'Angelina Jolie'
    fb_id 'ASD1231'
    fb_token 'A312D1'
    email 'angelina@jolie.com'

    factory :duplicated_email do
      name 'Brad Pitt'
      fb_id 'ASDAS12312'
      fb_token 'DKASOPD12312'
    end

    factory :invalid_user do
      name nil
      email nil
      fb_id nil
      fb_token nil
    end
  end
end
