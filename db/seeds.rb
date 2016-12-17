# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

Company.create(id: 1,
                name: "Granicus",
                website: "www.granicus.com",
                headquarters: "Denver, CO",
                products_services: "Computer Software",
                status: "approved",
                size: "51-200",
                logo: File.new('db/seed_logos/granicus_logo.png'))
Location.create(street_address: "707 17th Street",
                street_address_2: "Suite 4000",
                phone: "720-240-9586",
                status: "approved",
                primary_contact: "Chris Downard",
                company_id: 1,
                zip_code: "80202",
                city: "Denver",
                state: "CO")

Company.create(id: 2,
                name: "SpotX",
                website: "www.spotxchange.com",
                headquarters: "Denver, CO",
                products_services: "Software",
                status: "approved",
                size: "201-500",
                logo: File.new('db/seed_logos/SpotX_Logo.png'))
Location.create(street_address: "11030 CirclePoint Road",
                street_address_2: "Suite 350",
                phone: "303.345.6650",
                status: "approved",
                primary_contact: "Allen Dove, CTIO",
                company_id: 2,
                zip_code: "80020",
                city: "Denver",
                state: "CO")

Company.create(id: 3,
                name: "MondoRobot",
                website: "www.mondorobot.com",
                headquarters: "Boulder, CO",
                products_services: "Digital Strategies, UI & UX Design, Video & Animation, Mobile & Tablet, Applications, Websites, Virtual Reality, Digital Installations, Augmented Reality, Social Experiences, Branding & Identities, Interactive Games",
                status: "approved",
                size: "11-50",
                logo: File.new('db/seed_logos/MondoRobot_logo.png'))
Location.create(street_address: "5445 Conestoga Court",
                street_address_2: "suite 200",
                phone: "303.800.2916",
                status: "approved",
                primary_contact: "Rebekah Pinter, HR & Talent Manager",
                company_id: 3,
                zip_code: "80301",
                city: "Boulder",
                state: "CO")

Company.create(id: 4,
                name: "Captain U",
                website: "www.captainu.com",
                headquarters: "San Francisco, CA",
                products_services: "Computer Software",
                status: "approved",
                size: "11-50",
                logo: File.new('db/seed_logos/CaptainU.jpg'))
Location.create(street_address: "910 Santa Fe Dr.",
                street_address_2: "",
                phone: "",
                status: "approved",
                primary_contact: "",
                company_id: 4,
                zip_code: "80204",
                city: "Denver",
                state: "CO")

Company.create(id: 5,
                name: "Wazee Digital",
                website: "www.wazeedigital.com/",
                headquarters: "Denver, CO",
                products_services: "cloud-based storage, access, and licensing for enterprise-scale video libraries",
                status: "approved",
                size: "51-200",
                logo: File.new('db/seed_logos/Wazee_Digital.png'))
Location.create(street_address: "1515 Arapahoe Street",
                street_address_2: "Tower 3 Suite 400",
                phone: "720-382-2869",
                status: "approved",
                primary_contact: "",
                company_id: 5,
                zip_code: "80202",
                city: "Denver",
                state: "CO")

Company.create(id: 6,
                name: "ParkiFi",
                website: "denver.parkifi.com/",
                headquarters: "Denver, CO",
                products_services: "Real time parking assistance",
                status: "approved",
                size: "11-50",
                logo: File.new('db/seed_logos/ParkiFi.png'))
Location.create(street_address: "1451 Larimer St",
                street_address_2: "",
                phone: "724-256-7147",
                status: "approved",
                primary_contact: "",
                company_id: 6,
                zip_code: "80202",
                city: "Denver",
                state: "CO")

Company.create(id: 7,
                name: "Tokken",
                website: "tokken.com",
                headquarters: "Denver, CO",
                products_services: "Financial Products for the cannabis industry",
                status: "approved",
                size: "2-10",
                logo: File.new('db/seed_logos/Tokken_logo.png'))
Location.create(street_address: "383 Corona Street",
                street_address_2: "",
                phone: "720-237-9836",
                status: "approved",
                primary_contact: "Adam Healy",
                company_id: 7,
                zip_code: "80218",
                city: "Denver",
                state: "CO")

Company.create(id: 8,
                name: "GoSpotCheck",
                website: "gospotcheck.com",
                headquarters: "Denver, CO",
                products_services: "Web apps for field operations",
                status: "approved",
                size: "51-200",
                logo: File.new('db/seed_logos/GoSPotCheck_logo.png'))
Location.create(street_address: "1520 Market St",
                street_address_2: "",
                phone: "844-359-2502",
                status: "approved",
                primary_contact: "Erin Hallows",
                company_id: 8,
                zip_code: "80202",
                city: "Denver",
                state: "CO")

Company.create(id: 9,
                name: "Rachio",
                website: "rachio.com",
                headquarters: "Denver, CO",
                products_services: "Smart sprinklers",
                status: "approved",
                size: "11-50",
                logo: File.new('db/seed_logos/rachio_logo.png'))
Location.create(street_address: "2040 Larimer St.",
                street_address_2: "",
                phone: "",
                status: "approved",
                primary_contact: "Kyle Hansen",
                company_id: 9,
                zip_code: "80205",
                city: "Denver",
                state: "CO")

Company.create(id: 10,
              name: 'FullContact',
               website: 'fullcontact.com',
               headquarters: 'Denver, CO',
               products_services: 'FullContact is the most powerful fully-connected contact management platform for professionals and enterprises who need to master their contacts and be awesome with people.',
               status: 'approved',
               size: '51-200',
              #  industry_id: 10,
               logo: File.new('db/seed_logos/full_contact_logo.png'))
Location.create(street_address: '1755 Blake St.',
                street_address_2: 'Suite #450',
                phone: '888-330-6943',
                primary_contact: 'Kaspars Dancis',
                company_id: 10,
                status: 'approved',
                zip_code: '80202',
                city: 'Denver',
                state: 'CO')

Company.create(id: 11,
               name: 'SendGrid',
               website: 'sendgrid.com',
               headquarters: 'Denver, CO',
               products_services: 'Delivers transactional and marketing emails through one reliable platform.',
               status: 'approved',
               size: '201-500',
              #  industry_id: 10,
               logo: File.new('db/seed_logos/SendGrid-Logo.png'))
Location.create(street_address: '1801 California St.',
                street_address_2: 'Suite 500',
                phone: '888-985-7363',
                primary_contact: 'Pattie Money',
                company_id: 11,
                status: 'approved',
                zip_code: '80202',
                city: 'Denver',
                state: 'CO')

Company.create(id: 12,
               name: 'CacheMatrix',
               website: 'cachematrix.com',
               headquarters: 'Denver, CO',
               products_services: 'Cachematrix simplifies cash management for leading banks and their corporate clients.',
               status: 'approved',
               size: '51-200',
              #  industry_id: 7,
               logo: File.new('db/seed_logos/CacheMatrixlogo.png'))

Location.create(street_address: '44 Cook St.',
                street_address_2: '8th Floor',
                phone: '303-468-5500',
                primary_contact: 'Kevin Sun',
                company_id: 12,
                status: 'approved',
                zip_code: '80206',
                city: 'Denver',
                state: 'CO')



Industry.create(id: 1, name: "Computer Software")
Industry.create(id: 2, name: "Internet")
Industry.create(id: 3, name: "Marketing and Advertising")
Industry.create(id: 4, name: "Sports")
Industry.create(id: 5, name: "Broadcast Media")
Industry.create(id: 6, name: "Transportation/Trucking/Railroad")
Industry.create(id: 7, name: "Financial Software")
Industry.create(id: 8, name: "Internet of Things")
Industry.create(id: 9,name: 'Contact Management')


CompanyIndustry.create(id: 1, company_id: 1, industry_id: 1)
CompanyIndustry.create(id: 2, company_id: 2, industry_id: 2)
CompanyIndustry.create(id: 3, company_id: 3, industry_id: 3)
CompanyIndustry.create(id: 4, company_id: 4, industry_id: 4)
CompanyIndustry.create(id: 5, company_id: 5, industry_id: 5)
CompanyIndustry.create(id: 6, company_id: 6, industry_id: 6)
CompanyIndustry.create(id: 7, company_id: 7, industry_id: 7)
CompanyIndustry.create(id: 8, company_id: 8, industry_id: 1)
CompanyIndustry.create(id: 9, company_id: 9, industry_id: 8)
CompanyIndustry.create(id: 10, company_id: 10, industry_id: 9)
CompanyIndustry.create(id: 11, company_id: 11, industry_id: 9)
CompanyIndustry.create(id: 12, company_id: 12, industry_id: 7)
