class AddColumnToPromotion < ActiveRecord::Migration[6.1]
  def change
    add_column :promotions, :statut, :string
    # add_check_constraint :promotions, 'statut IN ("OUVERTE", "CLOTUREE")'
  end
end
