class CreateVisites < ActiveRecord::Migration[6.1]
  def change
    create_table :visites do |t|
      t.date :date
      t.string :statut
      t.boolean :relance
      t.string :commentaire

      t.belongs_to :stage, foreign_key: true
    end
  end
end
