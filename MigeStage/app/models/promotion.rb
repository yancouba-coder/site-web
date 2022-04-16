class Promotion < ApplicationRecord
  has_many :formations
  has_many :disponibilites

  enum statut: { :OUVERTE => 'OUVERTE', :CLOTUREE => 'CLOTUREE' }

  validates :annee, presence: true

  def cloturer
    self.update(statut: :CLOTUREE)
  end

end
