module SeedFixtureData
  def self.run(path)
    lines = load_file(path)
    companies = group_into_companies(lines)
    industry = create_industry(path)
    load_companies(industry, companies)
  end

  private
    def self.load_file(path)
      raw_file = File.new(path)
      raw_lines = raw_file.readlines
      raw_lines.map { |line| line.chomp }
    end

    def self.create_industry(path)
      industry_name = File.basename(path, ".txt")
      Industry.find_or_create_by!(name: industry_name)
    end

    def self.group_into_companies(lines)
      companies = []
      lines.each_slice(10) do |ten_lines|
        companies << ten_lines
      end
      companies
    end

    def self.load_companies(industry, companies)
      companies.each do |company|
        name              = company[0]
        website           = company[4]
        headquarters      = company[5].sub("Company headquarters: ", "")
        products_services = company[6].sub("Products/Services: ", "")

        this_company = Company.create({
          name:              name,
          website:           website,
          headquarters:      headquarters,
          products_services: products_services,
        })

        industry.companies << this_company
        this_company.locations << Location.create(create_location(company))
      end
    end

    def self.create_location(company)
      street_address    = company[1]
      city_state_zip    = company[2]
      phone             = company[3]
      primary_contact   = company[7].sub("Person in charge: ", "")
      city              = company[2].split[0...-2].join(" ").gsub(",", "")
      state             = company[2].split[-2]
      zip_code          = company[2].split.last
      {
        street_address:  street_address,
        phone:           phone,
        primary_contact: primary_contact,
        city:            city,
        state:           state,
        zip_code:        zip_code
      }
    end
end
