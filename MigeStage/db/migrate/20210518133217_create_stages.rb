class CreateStages < ActiveRecord::Migration[6.1]
  def change
    create_table :stages do |t|
      t.string :sujet
      t.date :date_ratification_convention
      t.float :gratification
      t.string :type_stage
      t.string :commentaire

      t.belongs_to :etudiant, foreign_key: true
      t.belongs_to :formation, foreign_key: true
      t.belongs_to :entreprise, foreign_key: true
      t.belongs_to :tuteur_entreprise, foreign_key: true
      t.belongs_to :tuteur_universitaire, foreign_key: true
    end
    # add_check_constraint :stages, 'type_stage IN ("STAGE", "ALTERNANCE")'
  end
end
