#
# Pseudo-model to find one or an array of countries by different criterias
# Uses countries-gem as datasource
#
class Country
  def self.all
    ISO3166::Country.all.map{|c| {id: c.number, name: c.name, code: c.un_locode}}
  end

  def self.find_by_id id
    data = ISO3166::Country.find_country_by_number(id.to_s).data
    parse_data data
  end

  def self.find_by_name name
    data = ISO3166::Country.find_country_by_name(name).data
    parse_data data
  end

  def self.find_by_code code
    data = ISO3166::Country.find_country_by_un_locode(code).data
    parse_data data
  end

  def self.find_all_by_region name
    ISO3166::Country.find_all_countries_by_region(name).map{|c| {id: c.number, name: c.name, code: c.un_locode}}
  end

  private

  def parse_data data
    {
      id: data['number'],
      name: data['name'],
      code: data['un_locode']
    }
  end

end
