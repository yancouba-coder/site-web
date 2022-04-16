class Etudiant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #has_and_belongs_to_many :formations

  has_many :fiche_stages , dependent: :destroy
  has_one :tuteur_universitaires
  has_one_attached :rapport
  after_initialize :init

  #belongs_to :user, default: -> { Current.user }
  #attribute :tuteur_universitaires_id, default: 1
  def init
    self.tuteur_universitaires ||=1 if self.has_attribute? :tuteur_universitaires
  end


  enum statut_arrivant_L3: { MIAGE: 'MIAGE', DSPEG: 'DSPEG' }

  def name_with_initial
    "#{nom.upcase} #{prenom}"
  end

  def transfert(formation)
    self.formations << formation
    self.save
  end

end
