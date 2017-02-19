class LocationSerializer < ActiveModel::Serializer
  attributes :id, :street_address, :street_address_2, :city_state_zip, :phone, :primary_contact, :status, :coordinates
end
