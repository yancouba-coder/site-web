class Offre < ApplicationRecord
  has_and_belongs_to_many :technologies
  belongs_to :entreprise
end
