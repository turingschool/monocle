class Location < ApplicationRecord
  belongs_to :company


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

  def city_state_zip
    "#{city}, #{state} #{zip_code}"
  end

  private
    def set_status
      self.status ||= 0
    end

end
