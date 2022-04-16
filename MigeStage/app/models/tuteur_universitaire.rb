class TuteurUniversitaire < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :disponibilites


  enum statut_encadrant: { :INDUSTRIE => 'INDUSTRIE', :UNIVERSITAIRE => 'UNIVERSITAIRE' }
  
  validates :nom, :prenom, :alias, :email, :fonction, :localisation, presence: true

end
