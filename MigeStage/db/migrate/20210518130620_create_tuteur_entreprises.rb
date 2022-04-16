class CreateTuteurEntreprises < ActiveRecord::Migration[6.1]
  def change
    create_table :tuteur_entreprises do |t|
      t.string :nom
      t.string :prenom
      t.string :email
      t.string :telephone, limit: 10

      t.belongs_to :entreprise, foreign_key: true
      t.timestamps
    end
  end
end
