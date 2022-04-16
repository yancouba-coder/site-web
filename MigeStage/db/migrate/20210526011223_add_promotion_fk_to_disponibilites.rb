class AddPromotionFkToDisponibilites < ActiveRecord::Migration[6.1]
  def change
    add_reference :disponibilites, :promotion, index: true, foreign_key: true
    add_index :disponibilites, [:tuteur_universitaire_id, :promotion_id], :unique => true, name: 'index_disponibilites_unique'
  end
end
