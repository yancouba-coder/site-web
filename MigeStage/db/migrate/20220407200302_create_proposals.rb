class CreateProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.text :description
      t.string :rh
      t.string :entreprise
      t.string :typecontrat
      t.string :email
      t.string :telephone
      t.string :adresse
      t.string :lepdf
      t.string :statut

      t.timestamps
    end
  end
end
