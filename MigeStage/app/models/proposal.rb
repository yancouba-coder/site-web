class Proposal < ApplicationRecord
  has_one_attached :file
  validates :description, presence: true
  validates :rh, presence: true
  validates :adresse, presence: true

  validates :entreprise, presence: true
  validates :typecontrat, presence: true
  validates :email, presence: true

  validates :telephone, presence: true

end
