class CreateEntreprises < ActiveRecord::Migration[6.1]
  def change
    create_table :entreprises do |t|
      t.string :siren, limit: 14
      t.string :raison_sociale
      t.string :ville

      t.timestamps
    end
    add_index :entreprises, :siren, unique: true
  end
end
