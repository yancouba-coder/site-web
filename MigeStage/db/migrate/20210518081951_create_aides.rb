class CreateAides < ActiveRecord::Migration[6.1]
  def change
    create_table :aides do |t|
      t.boolean :cv_recu
      t.boolean :lettre_recu
      t.string :suivi
      t.boolean :present_reunion

      t.belongs_to :etudiant, foreign_key: true
      t.belongs_to :formation, foreign_key: true
    end
    add_index :aides, [:etudiant_id, :formation_id], unique: true
  end
end
