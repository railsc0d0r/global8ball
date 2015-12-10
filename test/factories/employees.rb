FactoryGirl.define do
  factory :employee do
    association :user, role_name: "Administrator"
    association :person
  end
end
