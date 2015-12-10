FactoryGirl.define do
  factory :player do
    association :user, strategy: :build
    association :person, strategy: :build
  end
end
