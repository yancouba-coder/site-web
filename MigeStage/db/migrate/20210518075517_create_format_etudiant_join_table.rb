class CreateFormatEtudiantJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :formations, :etudiants do |t|
      t.index :formation_id
      t.index :etudiant_id
    end

  end
end
