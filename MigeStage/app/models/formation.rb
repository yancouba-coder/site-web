class Formation < ApplicationRecord
  # Associations du modèle
  belongs_to :promotion
  has_and_belongs_to_many :etudiants

  # Enum
  enum mention: { L3: 'L3', M1: 'M1', M2: 'M2' }

  validates :promotion_id, :mention, :libelle, :email, :code_ue, presence: true

  def name_with_initial
    "#{mention.capitalize} #{promotion.annee}"
  end
end
