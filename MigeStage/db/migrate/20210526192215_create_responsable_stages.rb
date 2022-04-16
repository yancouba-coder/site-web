class CreateResponsableStages < ActiveRecord::Migration[6.1]
  def change
    create_table :responsable_stages do |t|
      t.string :nom
      t.string :prenom

      t.timestamps
    end
  end
end
