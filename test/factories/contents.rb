FactoryGirl.define do
  factory :content do
    language "en"
    sequence :headline do |n|
      "Headline-#{n}"
    end
    sequence :content do |n|
      "Here goes content #{n}"
    end
  end

end
