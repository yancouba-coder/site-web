class CreateFormations < ActiveRecord::Migration[6.1]
  def change
    create_table :formations do |t|
      t.string :mention
      t.string :libelle
      t.string :email
      t.string :code_ue

      t.belongs_to :promotion, foreign_key: true
    end
  end
end
