class AddCompteurToFicheStages < ActiveRecord::Migration[6.1]
  def change
    add_column :fiche_stages, :compteur, :decimal
  end
end
