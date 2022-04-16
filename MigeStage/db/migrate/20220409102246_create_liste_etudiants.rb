class CreateListeEtudiants < ActiveRecord::Migration[6.1]
  def change
    create_table :liste_etudiants do |t|
      t.integer :num_etudiant
      t.string :nom
      t.string :prenom
      t.string :email_universitaire
      t.string :email_personnel
      t.string :statut_arrivant_L3
      t.string :mention
      t.string :stage
      t.string :alternance


      t.timestamps
    end
  end
end
