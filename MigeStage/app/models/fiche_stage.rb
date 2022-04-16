class FicheStage < ApplicationRecord
  #belongs_to :formation
  belongs_to :etudiant
  validates :titre, presence: true
  validates :date_debut, presence: true
  validates :date_fin, presence: true

  validates :poste, presence: true
  validates :taches, presence: true
  validates :technologies, presence: true

  validates :contact_nom, presence: true
  validates :contact_prenom, presence: true
  validates :contact_poste, presence: true

  validates :tuteur_nom, presence: true
  validates :tuteur_prenom, presence: true
  validates :tuteur_fonction, presence: true
  validates :tuteur_telephone, presence: true
  validates :tuteur_email, presence: true

  validates :entreprise_nom, presence: true
  validates :entreprise_cp, presence: true
  validates :entreprise_ville, presence: true
  validates :entreprise_pays, presence: true

end
