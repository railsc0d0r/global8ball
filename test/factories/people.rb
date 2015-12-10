FactoryGirl.define do
  factory :person do
    sequence :lastname do |n|
      "Lastname_#{n}"
    end
    sequence :firstname do |n|
      "Firstname_#{n}"
    end
    sequence(:email) { |n| "person-#{n}@example.com" }
    association :address, factory: :address, strategy: :build
  end
end
