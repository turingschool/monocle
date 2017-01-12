class Company < ApplicationRecord
  include Filterable
  has_many :company_industries
  has_many :industries, through: :company_industries
  has_many :starred_companies
  has_many :users, through: :starred_companies
  has_many :notes
  has_many :locations
  mount_uploader :logo, LogoUploader
  scope :company_size, -> (size) { where('companies.size IN (?)', size) }
  scope :industry_ids, -> (industries) { joins(:industries).where('industries.name IN (?)', industries) }

  before_validation :set_status

  enum status: [:pending, :approved, :rejected]

  def approved
    self.status = 1
    self.save
  end

  def rejected
    self.status = 2
    self.save
  end

  def self.approved_companies
    Company.where('status = ?', '1')
  end

  def self.pending_companies
    Company.where('status = ?', '0')
  end

  def approved?
    self.status == "approved"
  end

  def approved_locations
    self.locations.where('status = ?', '1')
  end

  def get_coordinates
    if locations.first
      locations.first.coordinates
    else
      ''
    end
  end

  # def add_location(params)
  #   self.locations.new(
  #     street_address:   params[:street_address],
  #     street_address_2: params[:street_address_2],
  #     phone:            params[:phone],
  #     primary_contact:  params[:primary_contact],
  #     city:             params[:city],
  #     state:            params[:state],
  #     zip_code:         params[:zip_code]
  #   )
  # end

  def location_info(location = locations.first)
    if location
      location.full_location
    else
      []
    end
  end

  def attach_industries_and_location(industries, state, location_params)
    assign_industries(industries)
    attach_location(location_params, state)
  end

  def assign_industries(industry_ids)
    industry_ids.each do |industry_id|
      industry = Industry.find(industry_id)
      self.industries << industry
    end
  end

  def attach_location(location_params, state)
    location = locations.create(location_params)
    location.update(state: state)
    location.update(status: 'approved')
  end

  private
    def set_status
      self.status ||= 0
    end
end
