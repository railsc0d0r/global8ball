FactoryGirl.define do
  factory :content do
    language "en"
    sequence :headline do |n|
      "Headline-#{n}"
    end
    sequence :content do |n|
      "<p>Here goes content #{n}</p>"
    end
  end

end
