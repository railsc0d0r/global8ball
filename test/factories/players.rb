FactoryGirl.define do
  factory :player do
    association :user, strategy: :build
    association :person, strategy: :build
    card_number '123456789'
    id_type 'Passport'
    id_number '123456789'
    date_of_birth Date.today.years_ago(19)
  end
end
