Dir["#{Rails.root}/lib/patches/**/*.rb"].each do |r|
  require r
end
