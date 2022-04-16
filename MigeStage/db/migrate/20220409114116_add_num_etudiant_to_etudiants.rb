class AddNumEtudiantToEtudiants < ActiveRecord::Migration[6.1]
  def change
    Etudiant.connection.execute("ALTER TABLE etudiants
ADD foreign key (num_etudiant) REFERENCES liste_etudiants(num_etudiant)
ON UPDATE CASCADE ON DELETE SET NULL")



  end
end
