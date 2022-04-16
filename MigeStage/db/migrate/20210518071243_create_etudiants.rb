class CreateEtudiants < ActiveRecord::Migration[6.1]
  def change
    create_table :etudiants do |t|
      t.string :num_etudiant
      t.string :nom
      t.string :prenom
      t.string :email_universitaire
      t.string :email_personnel
      t.string :statut_arrivant_L3, limit: 5

      t.timestamps
    end

    add_index :etudiants, :num_etudiant, unique: true
    add_index :etudiants, :email_personnel, unique: true
    add_index :etudiants, :email_universitaire, unique: true
    # add_check_constraint :etudiants, 'statut_arrivant_L3 IN ("DSPEG", "MIAGE")'
  end
end
