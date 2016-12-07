class Company < ApplicationRecord
  has_many :company_industries
  has_many :industries, through: :company_industries
  has_many :starred_companies
  has_many :users, through: :starred_companies
  has_many :notes
  has_many :locations

  mount_uploader :logo, LogoUploader

  def self.approved_locations
    Company.joins(:locations).where('locations.status = ?', '1')
  end

  def self.pending_locations
    Company.joins(:locations).where('locations.status = ?', '0')
  end

  def approved?
    self.locations.any? { |location| location.approved? }
  end

  def approved_locations
    self.locations.where('status = ?', '1')
  end

  def add_location(params)
    self.locations.new(
      street_address:   params[:street_address],
      street_address_2: params[:street_address_2],
      phone:            params[:phone],
      primary_contact:  params[:primary_contact],
      city:             params[:city],
      state:            params[:state],
      zip_code:         params[:zip_code]
    )
  end
end
