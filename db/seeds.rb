cs = Industry.create(name: "Computer Software")
internet = Industry.create(name: "Internet")
marketing = Industry.create(name: "Marketing and Advertising")
sports = Industry.create(name: "Sports")
media = Industry.create(name: "Broadcast Media")
transportation = Industry.create(name: "Transportation/Trucking/Railroad")
financial = Industry.create(name: "Financial Software")
iot = Industry.create(name: "Internet of Things")
contact = Industry.create(name: 'Contact Management')

granicus = Company.create(
                name: "Granicus",
                website: "www.granicus.com",
                products_services: "Computer Software",
                status: "approved",
                size: "51-200",
                logo: File.new('db/seed_logos/granicus_logo.png'))
granicus.locations.create(street_address: "707 17th Street",
                street_address_2: "Suite 4000",
                phone: "720-240-9586",
                status: "approved",
                primary_contact: "Chris Downard",
                zip_code: "80202",
                city: "Denver",
                state: "CO")
granicus.industries << cs

spotx = Company.create(
                name: "SpotX",
                website: "www.spotxchange.com",
                products_services: "Software",
                status: "approved",
                size: "201-500",
                logo: File.new('db/seed_logos/SpotX_Logo.png'))
spotx.locations.create(street_address: "11030 CirclePoint Road",
                street_address_2: "Suite 350",
                phone: "303.345.6650",
                status: "approved",
                primary_contact: "Allen Dove, CTIO",
                zip_code: "80020",
                city: "Denver",
                state: "CO")
spotx.industries << internet

mondorobot = Company.create(
                name: "MondoRobot",
                website: "www.mondorobot.com",
                products_services: "Digital Strategies, UI & UX Design, Video & Animation, Mobile & Tablet, Applications, Websites, Virtual Reality, Digital Installations, Augmented Reality, Social Experiences, Branding & Identities, Interactive Games",
                status: "approved",
                size: "11-50",
                logo: File.new('db/seed_logos/MondoRobot_logo.png'))
mondorobot.locations.create(street_address: "5445 Conestoga Court",
                street_address_2: "suite 200",
                phone: "303.800.2916",
                status: "approved",
                primary_contact: "Rebekah Pinter, HR & Talent Manager",
                zip_code: "80301",
                city: "Boulder",
                state: "CO")
mondorobot.industries << marketing

captainu = Company.create(
                name: "Captain U",
                website: "www.captainu.com",
                products_services: "Computer Software",
                status: "approved",
                size: "11-50",
                logo: File.new('db/seed_logos/CaptainU.jpg'))
captainu.locations.create(street_address: "910 Santa Fe Dr.",
                street_address_2: "",
                phone: "",
                status: "approved",
                primary_contact: "",
                zip_code: "80204",
                city: "Denver",
                state: "CO")
captainu.industries << sports

wazee = Company.create(
                name: "Wazee Digital",
                website: "www.wazeedigital.com/",
                products_services: "cloud-based storage, access, and licensing for enterprise-scale video libraries",
                status: "approved",
                size: "51-200",
                logo: File.new('db/seed_logos/Wazee_Digital.png'))
wazee.locations.create(street_address: "1515 Arapahoe Street",
                street_address_2: "Tower 3 Suite 400",
                phone: "720-382-2869",
                status: "approved",
                primary_contact: "",
                zip_code: "80202",
                city: "Denver",
                state: "CO")
wazee.industries << media

parkifi = Company.create(
                name: "ParkiFi",
                website: "denver.parkifi.com/",
                products_services: "Real time parking assistance",
                status: "approved",
                size: "11-50",
                logo: File.new('db/seed_logos/ParkiFi.png'))
parkifi.locations.create(street_address: "1451 Larimer St",
                street_address_2: "",
                phone: "724-256-7147",
                status: "approved",
                primary_contact: "",
                zip_code: "80202",
                city: "Denver",
                state: "CO")
parkifi.industries << transportation

tokken = Company.create(
                name: "Tokken",
                website: "tokken.com",
                products_services: "Financial Products for the cannabis industry",
                status: "approved",
                size: "2-10",
                logo: File.new('db/seed_logos/Tokken_Logo.png'))

tokken.locations.create(street_address: "383 Corona Street",
                street_address_2: "",
                phone: "720-237-9836",
                status: "approved",
                primary_contact: "Adam Healy",
                zip_code: "80218",
                city: "Denver",
                state: "CO")
tokken.industries << financial

gospotcheck = Company.create(
                name: "GoSpotCheck",
                website: "gospotcheck.com",
                products_services: "Web apps for field operations",
                status: "approved",
                size: "51-200",
                logo: File.new('db/seed_logos/GoSpotCheck_logo.png'))

gospotcheck.locations.create(street_address: "1520 Market St",
                street_address_2: "",
                phone: "844-359-2502",
                status: "approved",
                primary_contact: "Erin Hallows",
                zip_code: "80202",
                city: "Denver",
                state: "CO")
gospotcheck.industries << cs

rachio = Company.create(
                name: "Rachio",
                website: "rachio.com",
                products_services: "Smart sprinklers",
                status: "approved",
                size: "11-50",
                logo: File.new('db/seed_logos/rachio_logo.png'))
rachio.locations.create(street_address: "2040 Larimer St.",
                street_address_2: "",
                phone: "",
                status: "approved",
                primary_contact: "Kyle Hansen",
                zip_code: "80205",
                city: "Denver",
                state: "CO")
rachio.industries << iot

fullcontact = Company.create(
              name: 'FullContact',
               website: 'fullcontact.com',
               products_services: 'FullContact is the most powerful fully-connected contact management platform for professionals and enterprises who need to master their contacts and be awesome with people.',
               status: 'approved',
               size: '51-200',
               logo: File.new('db/seed_logos/full_contact_logo.png'))
fullcontact.locations.create(street_address: '1755 Blake St.',
                street_address_2: 'Suite #450',
                phone: '888-330-6943',
                primary_contact: 'Kaspars Dancis',
                status: 'approved',
                zip_code: '80202',
                city: 'Denver',
                state: 'CO')
fullcontact.industries << contact

sendgrid = Company.create(
               name: 'SendGrid',
               website: 'sendgrid.com',
               products_services: 'Delivers transactional and marketing emails through one reliable platform.',
               status: 'approved',
               size: '201-500',
              #  industry_id: 10,
               logo: File.new('db/seed_logos/SendGrid-Logo.png'))
sendgrid.locations.create(street_address: '1801 California St.',
                street_address_2: 'Suite 500',
                phone: '888-985-7363',
                primary_contact: 'Pattie Money',
                status: 'approved',
                zip_code: '80202',
                city: 'Denver',
                state: 'CO')
sendgrid.industries << contact

cachematrix = Company.create(
               name: 'CacheMatrix',
               website: 'cachematrix.com',
               products_services: 'Cachematrix simplifies cash management for leading banks and their corporate clients.',
               status: 'approved',
               size: '51-200',
            #  industry_id: 7,
             logo: File.new('db/seed_logos/CacheMatrixlogo.png'))

cachematrix.locations.create(street_address: '44 Cook St.',
              street_address_2: '8th Floor',
              phone: '303-468-5500',
              primary_contact: 'Kevin Sun',
              status: 'approved',
              zip_code: '80206',
              city: 'Denver',
              state: 'CO')
cachematrix.industries << financial
