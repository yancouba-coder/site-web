class CreateFicheStages < ActiveRecord::Migration[6.1]
  def change
    create_table :fiche_stages do |t|
      t.string :titre
      t.string :type_stage
      t.string :mention
      t.date :date_debut
      t.date :date_fin
      t.string :statut

      t.string :poste
      t.string :taches
      t.string :technologies

      t.string :contact_nom
      t.string :contact_prenom
      t.string :contact_poste

      t.string :tuteur_nom
      t.string :tuteur_prenom
      t.string :tuteur_fonction
      t.string :tuteur_telephone
      t.string :tuteur_email

      t.string :entreprise_nom
      t.string :entreprise_siren
      t.string :entreprise_cp
      t.string :entreprise_ville
      t.string :entreprise_pays

      t.string :commentaire_validation

      t.timestamps

      t.belongs_to :etudiant, foreign_key: true
    end
    # add_check_constraint :fiche_stages, 'statut IN ("BROUILLON", "VALIDEE","REFUSEE","EN_ATTENTE_DE_VALIDATION")'
    # add_check_constraint :fiche_stages, 'type_stage IN ("ALTERNANCE","STAGE")'
    # add_check_constraint :fiche_stages, 'mention IN ("L3","M1","M2")'
  end
end
