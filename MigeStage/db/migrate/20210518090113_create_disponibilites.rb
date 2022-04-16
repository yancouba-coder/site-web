class CreateDisponibilites < ActiveRecord::Migration[6.1]
  def change
    create_table :disponibilites do |t|
      t.integer :nb_etudiants_souhaite
      t.string :statut_reponse

      t.belongs_to :tuteur_universitaire
      t.belongs_to :formation

      t.timestamps
    end
    # add_check_constraint :disponibilites, 'statut_reponse IN ("OK","ABANDON","PAS_DE_REPONSE")'
  end

end
