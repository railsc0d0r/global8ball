class Country
  def self.all
    ISO3166::Country.all.map{|c| {id: c.number, name: c.name, code: c.un_locode}}
  end

  def self.find_by_id id
    ISO3166::Country.find_country_by_number(id.to_s).data
  end

  def self.find_by_name name
    ISO3166::Country.find_country_by_name(name).data
  end

  def self.find_by_code code
    ISO3166::Country.find_country_by_un_locode(code).data
  end

  def self.find_all_by_region name
    ISO3166::Country.find_all_countries_by_region(name).map{|c| c.data}
  end

end
