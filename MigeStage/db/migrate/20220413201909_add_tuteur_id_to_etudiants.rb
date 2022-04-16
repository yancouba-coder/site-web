class AddTuteurIdToEtudiants < ActiveRecord::Migration[6.1]
  def change
    add_column :etudiants, :tuteurid, :bigint
  end
end
