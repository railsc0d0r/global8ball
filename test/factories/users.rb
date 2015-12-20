FactoryGirl.define do
  factory :user do
    :role
    sequence :username do |n|
      "myLogin#{n}"
    end
    sequence :email do |n|
      "my_mail#{n}@global8ball.com"
    end
    password "secret123456789"
    password_confirmation "secret123456789"
    sign_in_count 0
    activated true
  end

end
