json.array! @companies do |company|
  json.id       company.id
  json.logo     company.logo.url
  json.name     company.name
  json.website  company.website
  json.location company.location_info
  json.coordinates company.get_coordinates
end
