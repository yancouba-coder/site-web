class CreateJoinTableOffreTechno < ActiveRecord::Migration[6.1]
  def change
    create_join_table :offres, :technologies do |t|
      t.index :offre_id
      t.index :technology_id
    end
  end
end
