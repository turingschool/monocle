namespace :db do
  desc "Import companies into the database from a parsed text file"
  # The text file must be formatted with exactly one company per exactly ten lines with exactly one attribute per line in the order of: name, street_address, city_state_zip, phone, website, headquarters, products_services, person_in_charge
  task :seed_test_fixture, [:path] => :environment do |t, args|
    prior_category_count = Category.count
    prior_company_count = Company.count

    puts "Reading from file: #{args[:path]}"
    lines = File.new(args[:path]).readlines.map { |line| line.chomp }

    category_name = File.basename(args[:path], ".txt")
    category = Category.find_or_create_by!(name: category_name)

    companies = []

    lines.each_slice(10) do |ten_lines|
      companies << ten_lines
    end

    puts "Importing companies into database..."
    companies.each do |company|
      name              = company[0]
      street_address    = company[1]
      city_state_zip    = company[2]
      phone             = company[3]
      website           = company[4]
      headquarters      = company[5].sub("Company headquarters: ", "")
      products_services = company[6].sub("Products/Services: ", "")
      person_in_charge  = company[7].sub("Person in charge: ", "")

      category.companies << Company.new({
        name:              name,
        street_address:    street_address,
        city_state_zip:    city_state_zip,
        phone:             phone,
        website:           website,
        headquarters:      headquarters,
        products_services: products_services,
        person_in_charge:  person_in_charge
      })
    end

    final_category_count = Category.count
    final_company_count = Company.count
    puts "Processing is now complete"
    puts "New categories: #{final_category_count - prior_category_count}"
    puts "New companies: #{final_company_count - prior_company_count}"
  end
end
