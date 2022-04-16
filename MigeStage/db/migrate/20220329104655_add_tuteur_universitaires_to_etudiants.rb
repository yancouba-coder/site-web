class AddTuteurUniversitairesToEtudiants < ActiveRecord::Migration[6.1]
  def change
    add_reference :etudiants, :tuteur_universitaires, null: false, foreign_key: true
  end
end
