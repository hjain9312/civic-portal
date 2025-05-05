class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :complaint_type
  geocoded_by :coordinates   # virtual method
  after_validation :reverse_geocode, if: ->(obj){ obj.latitude.present? && obj.longitude.present? }

  def coordinates
    [latitude, longitude]
  end

  has_one_attached :proof_image

  validates :complaint_type, :description, :complaint_type, presence: true
end
