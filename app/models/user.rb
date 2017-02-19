class User < ApplicationRecord
  validate :user_must_have_fields_for_provider
  has_many :starred_companies
  has_many :starred_jobs
  has_many :companies, through: :starred_companies
  has_many :notes

  before_validation :set_role

  enum role: [:standard, :moderator, :admin]

  def self.create_from_census(user_info)
    user = find_or_initialize_by(census_uid: user_info["uid"]) do |u|
      if user_info.info["first_name"] && user_info.info["last_name"]
        u.username = user_info.info["first_name"] + " " + user_info.info["last_name"]
      end
    end
    user.census_access_token = user_info.credentials["token"]
    user.save ? user : false
  end

  def star(company)
    companies << company unless companies.exists?(id: company.id)
  end

  private
    def set_role
      self.role ||= 0
    end

    def user_must_have_fields_for_provider
      unless username && census_uid && census_access_token
        errors.add(:username, "is missing data")
      end
    end
end
