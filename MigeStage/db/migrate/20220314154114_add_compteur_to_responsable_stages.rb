class AddCompteurToResponsableStages < ActiveRecord::Migration[6.1]
  def change
    add_column :responsable_stages, :compteur, :decimal
  end
end
