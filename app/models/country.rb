#
# Pseudo-model to find one or an array of countries by different criterias
# Uses countries-gem as datasource -> https://github.com/hexorx/countries
#
class Country
  def self.all
    ISO3166::Country.all.map{|c| {id: c.number, name: c.name, code: c.un_locode}}
  end

  def self.find_by_id id
    country =  ISO3166::Country.find_country_by_number(id.to_s)
    if country
      filter_attributes country
    end
  end

  def self.find_by_name name
    country = ISO3166::Country.find_country_by_name(name)
    if country
      filter_attributes country
    end
  end

  def self.find_by_code code
    country = ISO3166::Country.find_country_by_un_locode(code)
    if country
      filter_attributes country
    end
  end

  def self.find_all_by_region name
    ISO3166::Country.find_all_countries_by_region(name).map{|c| {id: c.number, name: c.name, code: c.un_locode}}
  end

  private

  def self.filter_attributes country
    {
      id: country.number,
      name: country.name,
      code: country.un_locode
    }
  end

end
