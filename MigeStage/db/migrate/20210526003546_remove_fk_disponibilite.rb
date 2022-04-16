class RemoveFkDisponibilite < ActiveRecord::Migration[6.1]
  def change
    if foreign_key_exists?(:disponibilites, :formations)
      remove_foreign_key :disponibilities, :formations
      remove_index :disponibilites, :formation_id
      remove_column :disponibilites, :formation_id
    end
  end
end
