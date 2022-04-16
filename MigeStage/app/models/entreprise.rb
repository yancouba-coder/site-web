class Entreprise < ApplicationRecord
  has_many :offres

  def initialize(attributes = nil)
    super
    self.pays = 'France'
  end

  validates :siren, :raison_sociale, :ville, :pays, presence: true

end
