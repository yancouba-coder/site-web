class CreateTuteurUniversitaires < ActiveRecord::Migration[6.1]
  def change
    create_table :tuteur_universitaires do |t|
      t.string :nom
      t.string :prenom
      t.string :alias
      t.string :email
      t.string :statut_encadrant
      t.string :fonction
      t.string :localisation

      t.timestamps
    end

    # add_check_constraint :tuteur_universitaires, 'statut_encadrant IN ("INDUSTRIE", "UNIVERSITAIRE")'
  end
end
