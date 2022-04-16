class AddNumEtudiantToListeEtudiants < ActiveRecord::Migration[6.1]
  def change
    add_column :liste_etudiants, :num_etudiant, :integer
    add_index :liste_etudiants, :num_etudiant, unique: true

  end
end
