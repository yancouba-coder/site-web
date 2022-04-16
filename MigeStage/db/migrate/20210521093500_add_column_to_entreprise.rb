class AddColumnToEntreprise < ActiveRecord::Migration[6.1]
  def change
    add_column :entreprises, :pays, :string, default: 'France'
  end
end
